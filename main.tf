data "azurerm_subscription" "current" {}

resource "azurerm_subscription_policy_assignment" "regulatory_compliance" {
  name                 = "Softcat-ASB-${data.azurerm_subscription.current.subscription_id}"
  policy_definition_id = "/providers/Microsoft.Authorization/policySetDefinitions/1f3afdf9-d0c9-4c3d-847f-89da613e70a8"
  subscription_id      = data.azurerm_subscription.current.id
  display_name         = "Softcat-ASB-${data.azurerm_subscription.current.subscription_id}"
  description          = "The Azure Security Benchmark initiative represents the policies and controls implementing security recommendations defined in Azure Security Benchmark v2, see https://aka.ms/azsecbm. This also serves as the Azure Security Center default policy initiative. You can directly assign this initiative, or manage its policies and compliance results within Azure Security Center. (Applied by Softcat Managed Azure Deployment)"
}