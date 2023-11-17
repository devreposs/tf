package test

import (
	"fmt"
	"testing"

	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestCreateSQL2016ENTInstance(t *testing.T) {
	name := fmt.Sprintf("mssql2016ent-%s", random.UniqueId())
	productCode := "tfmdltst"
	baselineWorkspaceName := "pmi-app-tfmdltst-prd-baseline"
	awsRegion := "eu-west-1"

	terraformOptions := &terraform.Options{
		TerraformDir: "../examples/sql-server-2016-enterprise",
		Vars: map[string]interface{}{
			"name":                    name,
			"product_code":            productCode,
			"baseline_workspace_name": baselineWorkspaceName,
		},
		NoColor: false,
	}

	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)

	actualInstanceID := []string{terraform.Output(t, terraformOptions, "id")}
	exptectedInstanceID := aws.GetEc2InstanceIdsByTag(t, awsRegion, "Name", name)
	assert.Equal(t, exptectedInstanceID, actualInstanceID)
}

func TestCreateSQL2019ENTInstance(t *testing.T) {
	name := fmt.Sprintf("msql2019ent-%s", random.UniqueId())
	productCode := "tfmdltst"
	baselineWorkspaceName := "pmi-app-tfmdltst-prd-baseline"
	awsRegion := "eu-west-1"

	terraformOptions := &terraform.Options{
		TerraformDir: "../examples/sql-server-2019-enterprise",
		Vars: map[string]interface{}{
			"name":                    name,
			"product_code":            productCode,
			"baseline_workspace_name": baselineWorkspaceName,
		},
		NoColor: false,
	}

	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)

	actualInstanceID := []string{terraform.Output(t, terraformOptions, "id")}
	exptectedInstanceID := aws.GetEc2InstanceIdsByTag(t, awsRegion, "Name", name)
	assert.Equal(t, exptectedInstanceID, actualInstanceID)
}
