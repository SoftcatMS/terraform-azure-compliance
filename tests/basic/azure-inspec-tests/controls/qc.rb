# copyright: 2018, The Authors

# Test values

describe azure_policy_assignments do
  its('names') { should include('Softcat-ASB-652f2afd-d7ca-4ffb-977e-de679adc4b03') }
end