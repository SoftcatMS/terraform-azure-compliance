data "azurerm_client_config" "current" {}
data "azurerm_subscription" "current" {}
data "azurerm_resource_group" "compliance" {
  name = var.resource_group_name
}

resource "azurerm_log_analytics_workspace" "regulatory_compliance" {
  name                = var.log_analytics_workspace_name
  location            = var.location != null ? var.location : data.azurerm_resource_group.compliance.location
  resource_group_name = data.azurerm_resource_group.compliance.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags                = var.tags
}

resource "azurerm_log_analytics_solution" "regulatory_compliance" {
  solution_name         = "SecurityCenterFree"
  location              = var.location != null ? var.location : data.azurerm_resource_group.compliance.location
  resource_group_name   = data.azurerm_resource_group.compliance.name
  workspace_resource_id = azurerm_log_analytics_workspace.regulatory_compliance.id
  workspace_name        = azurerm_log_analytics_workspace.regulatory_compliance.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/SecurityCenterFree"
  }
}

resource "azurerm_subscription_policy_assignment" "regulatory_compliance" {
  name                 = "Azure Security Benchmark"
  policy_definition_id = "/providers/Microsoft.Authorization/policySetDefinitions/1f3afdf9-d0c9-4c3d-847f-89da613e70a8"
  subscription_id      = data.azurerm_subscription.current.id
  display_name         = "Azure Security Benchmark"
  description          = "The Azure Security Benchmark initiative represents the policies and controls implementing security recommendations defined in Azure Security Benchmark v2, see https://aka.ms/azsecbm. This also serves as the Azure Security Center default policy initiative. You can directly assign this initiative, or manage its policies and compliance results within Azure Security Center. (Applied by Softcat Managed Azure Deployment)"
}

resource "azurerm_security_center_automation" "regulatory_compliance" {
  name                = "ExportToWorkspace"
  location            = var.location != null ? var.location : data.azurerm_resource_group.compliance.location
  resource_group_name = data.azurerm_resource_group.compliance.name

  action {
    type        = "LogAnalytics"
    resource_id = azurerm_log_analytics_workspace.regulatory_compliance.id

  }

  source {
    event_source = "RegulatoryComplianceAssessment"

  }
  source {
    event_source = "RegulatoryComplianceAssessmentSnapshot"

  }

  scopes = ["/subscriptions/${data.azurerm_client_config.current.subscription_id}"]
}
