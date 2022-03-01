module "regulatorycompliance" {
  source                        = "git@github.com:SoftcatMS/terraform-azure-compliance"
  location                      = "uksouth"
  resource_group_name           = "rg-example-compliance"
  log_analytics_workspace_name  = "example-log-workspace"

  tags = {
    environment = "test"
    engineer    = "ci/cd"
  }
}