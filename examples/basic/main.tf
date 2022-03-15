resource "azurerm_resource_group" "rg-example-compliance" {
  name     = "rg-example-compliance"
  location = "uksouth"
}

module "regulatorycompliance" {
  # source                        = "../../" #Local source only used for testing
  source                        = "git@github.com:SoftcatMS/terraform-azure-compliance" #GitHub SSH source wused for workflows
  location                      = "uksouth"
  resource_group_name           = azurerm_resource_group.rg-example-compliance.name
  log_analytics_workspace_name  = "example-log-workspace"

  tags = {
    environment = "example"
    engineer    = "ci/cd"
  }
  depends_on = [azurerm_resource_group.rg-example-compliance]
}