module "regulatorycompliance" {
  source                        = "git@github.com:SoftcatMS/terraform-azure-compliance" #GitHub SSH source wused for workflows
  location                      = "uksouth"
  resource_group_name           = "rg-example-compliance"
  log_analytics_workspace_name  = "example-log-workspace"

  tags = {
    environment = "test"
    engineer    = "ci/cd"
  }
}