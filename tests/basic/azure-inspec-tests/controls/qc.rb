# copyright: 2018, The Authors

# Test values

describe azure_policy_assignments do
  its('names') { should include('Azure Security Benchmark') }
end