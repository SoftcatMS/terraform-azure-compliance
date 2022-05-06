# copyright: 2018, The Authors

# Test values

resource_group1 = 'rg-test-compliance'

describe azure_policy_assignments(resource_group: resource_group1) do
  its('names') { should include('Azure Security Benchmark') }
end