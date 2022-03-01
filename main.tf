data "azurerm_subscription" "current" {}

resource "azurerm_resource_group" "regulatory_compliance" {
  name = "${var.resource_group_name}"
  location = var.location
  tags = var.tags
}

resource "azurerm_log_analytics_workspace" "regulatory_compliance" {
    name = "${var.log_analytics_workspace_name}"
    location = azurerm_resource_group.regulatory_compliance.location
    resource_group_name = azurerm_resource_group.regulatory_compliance.name
    sku = "PerGB2018"
    retention_in_days = 30
    tags = var.tags
}

resource "azurerm_subscription_policy_assignment" "regulatory_compliance" {
  name                 = "Azure Security Benchmark"
  policy_definition_id = "/providers/Microsoft.Authorization/policySetDefinitions/1f3afdf9-d0c9-4c3d-847f-89da613e70a8"
  subscription_id      = azurerm_subscription.current.id
}

resource "azurerm_security_center_automation" "regulatory_compliance" {
  name                = "softcat-managedazure-regulatory-compliance"
  location            = azurerm_resource_group.regulatory_compliance.location
  resource_group_name = azurerm_resource_group.regulatory_compliance.name

  action {
    type              = "LogAnalytics"
    resource_id       = azurerm_log_analytics_workspace.regulatory_compliance.id
    
  }

  source {
    event_source = "RegulatoryComplianceAssessment"
    rule_set {
      rule {
        property_path  = "properties.metadata.severity"
        operator       = "Equals"
        expected_value = "Azure Security Benchmark"
        property_type  = "String"
      }
    }
  }

  scopes = ["/subscriptions/${data.azurerm_client_config.current.subscription_id}"]
}
