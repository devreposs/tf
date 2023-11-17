package test

import (
	"fmt"
	"testing"
	"regexp"

	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestReHostCompositeModule(t *testing.T) {
	appservername := fmt.Sprintf("ReHostCM-app-%s", random.UniqueId())
	webservername := fmt.Sprintf("ReHostCM-web-%s", random.UniqueId())
	dbservername := fmt.Sprintf("ReHostCM-db-%s", random.UniqueId())
	productCode := "tfmdltst"
	baselineWorkspaceName := "pmi-app-tfmdltst-prd-baseline"
	awsRegion := "eu-west-1"

	terraformOptions := &terraform.Options{
		TerraformDir: "../examples/re-host-basic",
		Vars: map[string]interface{}{
			"baseline_workspace_name": baselineWorkspaceName,
			"app_server_name": appservername,
			"web_server_name": webservername,
			"db_server_name": dbservername,
			"product_code": productCode,
		},
		NoColor: false,
	}

	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)

	// Actual EC2 instance details
	appServerActualInstanceID := terraform.Output(t, terraformOptions, "app_server_ec2_ids")
	webServerActualInstanceID := terraform.Output(t, terraformOptions, "web_server_ec2_ids")
	dbServerActualInstanceID := terraform.Output(t, terraformOptions, "db_server_ec2_ids")

	// Get the private IP using Regexp
	re := regexp.MustCompile(`i-[a-z0-9]*`)
	appServerInstancePrivateIP := aws.GetPrivateIpOfEc2Instance(t, re.FindString(appServerActualInstanceID), awsRegion)
	webServerInstancePrivateIP := aws.GetPrivateIpOfEc2Instance(t, re.FindString(webServerActualInstanceID), awsRegion)
	dbServerInstancePrivateIP := aws.GetPrivateIpOfEc2Instance(t, re.FindString(dbServerActualInstanceID), awsRegion)

	// Verify we're getting back the outputs we expect for EC2
	ip_re := regexp.MustCompile(`[0-9.0-9.0-9.0-9]*`)
	assert.NotNil(t, ip_re.FindString(appServerInstancePrivateIP))
	assert.NotNil(t, ip_re.FindString(webServerInstancePrivateIP))
	assert.NotNil(t, ip_re.FindString(dbServerInstancePrivateIP))

	// Actual ASG instance details
	appAsgActualName := terraform.Output(t, terraformOptions, "asg_app_server_autoscaling_group_name")
	webAsgActualName := terraform.Output(t, terraformOptions, "asg_web_server_autoscaling_group_name")

	// Verify we're getting back the outputs we expect for ASG
	assert.Contains(t, appAsgActualName, appservername, "Created auto scaling group with name starting with ReHostCM-app")
	assert.Contains(t, webAsgActualName, webservername, "Created auto scaling group with name starting with ReHostCM-web")
}
