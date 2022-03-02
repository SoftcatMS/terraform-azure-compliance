module "regulatorycompliance" {
  # source                        = "../../" #Local source only used for testing
  source                        = "git@github.com:SoftcatMS/terraform-azure-compliance" #GitHub SSH source wused for workflows
  location                      = "uksouth"
  resource_group_name           = "rg-test-compliance"
  log_analytics_workspace_name  = "test-log-workspace"

  tags = {
    environment = "test"
    engineer    = "ci/cd"
  }
}