<powershell>

$dataDrive = ("${data_volume_name}", "D")
$logsDrive = ("${log_volume_name}", "E")
$tempDbDrive = ("${temp_volume_name}", "F")
$backupsDrive = ("${backup_volume_name}", "G")
$dataDrive1 = ("${data1_volume_name}", "H")
$dataDrive2 = ("${data1_volume_name}", "I")
$dataDrive3 = ("${data1_volume_name}", "J")
$dataDrive4 = ("${data1_volume_name}", "K")
$dataDrive5 = ("${data1_volume_name}", "L")

$environment = "${env}"
$sqlBackupsS3Bucket = "${sql_backups_s3_bucket}"
$mssqlBackupsDir = "\MSSQL\Backup"

# Ensure that SQL Server agent service is set to autostart
Invoke-Expression 'Set-Service SQLSERVERAGENT -StartupType Automatic' -Verbose -ErrorAction Ignore

# Configure disk layout (initialization, partition, format, disabling indexing and disk cache)
Invoke-Expression 'C:\ProgramData\SQLServerBootstrap\DiskInit.ps1 -dataDrive $dataDrive `
                                   -logsDrive $logsDrive `
                                   -tempDbDrive $tempDbDrive `
                                   -backupsDrive $backupsDrive `
                                   -dataDrive1 $dataDrive1 `
                                   -dataDrive2 $dataDrive2 `
                                   -dataDrive3 $dataDrive3 `
                                   -dataDrive4 $dataDrive4 `
                                   -dataDrive5 $dataDrive5' -Verbose -ErrorAction Ignore

# Grant SQL Server and Agent full control on disks
Invoke-Expression 'C:\ProgramData\SQLServerBootstrap\GrantSqlServerAccessToDisks.ps1 -sqlServerAccount  "NT Service\MSSQLSERVER" -sqlServerDriveLetters @($dataDrive[1], $logsDrive[1], $tempDbDrive[1], $backupsDrive[1], $dataDrive1[1], $dataDrive2[1], $dataDrive3[1], $dataDrive4[1], $dataDrive5[1])'
Invoke-Expression 'C:\ProgramData\SQLServerBootstrap\GrantSqlServerAccessToDisks.ps1 -sqlServerAccount  "NT Service\SQLSERVERAGENT" -sqlServerDriveLetters @($dataDrive[1], $logsDrive[1], $tempDbDrive[1], $backupsDrive[1], $dataDrive1[1], $dataDrive2[1], $dataDrive3[1], $dataDrive4[1], $dataDrive5[1])'

# Move TempDB to separate disk
Invoke-Expression 'C:\ProgramData\SQLServerBootstrap\TempDBLocation.ps1 -tempDbDriveLetter $tempDbDrive[1] -tempDbFolder \MSSQL\DATA\' -Verbose -ErrorAction Ignore

# Change SQL Server port according to environment
Invoke-Expression 'C:\ProgramData\SQLServerBootstrap\ChangeTCPPort.ps1 -environment $environment' -Verbose -ErrorAction Ignore

# Configure SQL Server maintenance plans
Invoke-Expression 'C:\ProgramData\SQLServerBootstrap\MaintenancePlans-01-Base.ps1 -backupsDriveLetter $backupsDrive[1] `
                                    -mssqlBackupsDir $mssqlBackupsDir' -Verbose -ErrorAction Ignore

Invoke-Expression 'C:\ProgramData\SQLServerBootstrap\MaintenancePlans-02-SysAndUserDbBackup.ps1 -backupsDriveLetter $backupsDrive[1] `
                                    -mssqlBackupsDir $mssqlBackupsDir `
                                    -sqlBackupsS3Bucket $sqlBackupsS3Bucket' -Verbose -ErrorAction Ignore

Invoke-Expression 'C:\ProgramData\SQLServerBootstrap\MaintenancePlans-03-DatabaseLogBackupUsers.ps1 -backupsDriveLetter $backupsDrive[1] `
                                    -mssqlBackupsDir $mssqlBackupsDir `
                                    -sqlBackupsS3Bucket $sqlBackupsS3Bucket' -Verbose -ErrorAction Ignore

# Set Model db recovery model
Invoke-Expression 'C:\ProgramData\SQLServerBootstrap\SetModelDbRecovery.ps1 -environment $environment' -Verbose -ErrorAction Ignore

# Apply local policies for SQL Server service account
Invoke-Expression 'C:\ProgramData\SQLServerBootstrap\LocalSecurityPolicies.ps1 -sqlServerAccount "NT Service\MSSQLSERVER" -localPolicies @("SeManageVolumePrivilege", "SeLockMemoryPrivilege")' -Verbose -ErrorAction Ignore

# Open SQL Server port in Windows Firewall
Invoke-Expression 'C:\ProgramData\SQLServerBootstrap\SQLFirewallRules.ps1 -environment $environment' -Verbose -ErrorAction Ignore

# Apply local policies for SQL Server service account
Invoke-Expression 'C:\ProgramData\SQLServerBootstrap\LocalSecurityPolicies.ps1 -sqlServerAccount "NT Service\MSSQLSERVER" -localPolicies @("SeManageVolumePrivilege", "SeLockMemoryPrivilege")' -Verbose -ErrorAction Ignore

# Execute SQL scripts
Invoke-Expression 'C:\ProgramData\SQLServerBootstrap\RunSQLScripts.ps1 -scriptsPath C:\ProgramData\SQLServerBootstrap\TSQL' -Verbose -ErrorAction Ignore

# Restarting server to apply all changes
Restart-Computer

</powershell>
