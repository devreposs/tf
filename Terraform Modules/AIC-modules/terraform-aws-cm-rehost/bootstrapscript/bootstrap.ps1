param ($tower_url, $job_template, $authtoken_secretname, $extra_vars_param_name )

add-type @"
using System.Net;
using System.Security.Cryptography.X509Certificates;
public class TrustAllCertsPolicy : ICertificatePolicy {
    public bool CheckValidationResult(
        ServicePoint srvPoint, X509Certificate certificate,
        WebRequest request, int certificateProblem) {
        return true;
    }
}
"@
$AllProtocols = [System.Net.SecurityProtocolType]'Ssl3,Tls,Tls11,Tls12'
[System.Net.ServicePointManager]::SecurityProtocol = $AllProtocols
[System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy

$ansible_token = (Get-SSMParameterValue -Name $authtoken_secretname -WithDecryption $True).Parameters[0].Value

$instanceid = Invoke-RestMethod -Uri "http://169.254.169.254/latest/meta-data/instance-id"

$limit = $instanceid + ",127.0.0.1"
If(-not $extra_vars_param_name)
{
    
    $data = @{
        limit=$limit
    }
} Else {
    $extra_vars = (Get-SSMParameterValue -Name $extra_vars_param_name -WithDecryption $True).Parameters[0].Value 
    
    $data = @{
        limit=$limit
        extra_vars="{$extra_vars}"
    }    
}

$Headers = @{
    Authorization = "bearer $ansible_token"
  }

$global_retry_attempts = 0
$continue = $true

$job_name_id = (Invoke-WebRequest -Headers $Headers -ContentType application/json -Method GET -Uri $tower_url/api/v2/job_templates/ -MaximumRedirection 0 -ErrorAction Ignore -UseBasicParsing).Content |
                ConvertFrom-Json |
                Select -expand results |
                Select id, name |
                Where { $_.name -eq $job_template }
$job_template_id = $job_name_id.id


while ($continue) {
    $global_retry_attempts++  
    $retry_attempts = 10
    $attempt = 0
    $joburl = ""
    $continue = $false
    if ($global_retry_attempts -gt 10) {
        break
    } 
    While ($attempt -lt $retry_attempts) {
        Try {
 
            $resp = Invoke-WebRequest -Headers $Headers -ContentType application/json -Method POST -Body (ConvertTo-Json $data) -Uri $tower_url/api/v2/job_templates/$job_template_id/launch/ -MaximumRedirection 0 -ErrorAction Ignore -UseBasicParsing
        
            If ($resp.StatusCode -match '^2[0-9]+$') {
                $jsonresp = $resp.Content | ConvertFrom-Json
                Write-Host "$($resp.StatusCode) received.. Job id: $($jsonresp.job)"
                $joburl = "$($tower_url)/api/v2/jobs/$($jsonresp.job)/"
                break
            } ElseIf ($resp.StatusCode -eq 404) {
                Write-Host "$($resp.StatusCode) received... encountered problem, halting"
                break
            }
        }
        Catch {
            $ex = $_
            $attempt++
            Write-Host "$ex received... retrying in 30 sec (Attempt $attempt)"
        }
        Start-Sleep -Seconds 30
    }

    If ($joburl -ne "") {
      $retry_attempts = 20
      $attempt = 0

      Start-Sleep -s 20
      While ($attempt -lt $retry_attempts) {
        Try {
          $jobresponse = Invoke-WebRequest -Headers $Headers -ContentType application/json -Method GET -Uri $joburl -UseBasicParsing
          $jsonresponse = $jobresponse.Content | ConvertFrom-Json
          if ( $jsonresponse.status -eq "running" ){
                Write-Host "$($jsonresponse.status) status received for job: $($joburl)....retrying in 1 minute (Attempt $attempt)"
                $attempt++
                if ($attempt -gt 1) {
                    break
                }
          } ElseIf ($jsonresponse.status -eq "failed") {
                $continue = $true   
                Write-Host "$($jsonresponse.status) status received for job: $($joburl)....Retrying after 1 min."
                Start-Sleep -s 60
                break

          } ElseIf ($jsonresponse.status -eq "canceled") {
                
                Write-Host "$($jsonresponse.status) status received for job: $($joburl)....Halting."
                break
                 
          } ElseIf ($jsonresponse.status -eq "successful"){
        
                Write-Host "$($jsonresponse.status) status received for job: $($joburl)."
                $jobresult = "success"
                break
          }
          Start-Sleep -s 60
        }
        Catch {
            $ex = $_
            Write-Host "$ex received for job url: $($joburl).... encountered problem, halting."
            break
        }
 
      }
}

}
