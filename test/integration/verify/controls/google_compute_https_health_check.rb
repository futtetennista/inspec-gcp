title 'Test GCP google_compute_https_health_check resource.'

gcp_project_id = input(:gcp_project_id, value: '', description: 'The GCP project identifier.')
https_health_check = input('https_health_check', value: {
  "name": "inspec-gcp-https-health-check",
  "request_path": "/https_health_check",
  "timeout_sec": 15,
  "check_interval_sec": 15,
  "unhealthy_threshold": 3
}, description: 'HTTPS health check definition')

control 'google_compute_https_health_check-1.0' do
  impact 1.0
  title 'google_compute_https_health_check resource test'

  describe google_compute_https_health_check(project: gcp_project_id, name: https_health_check['name']) do
    it { should exist }
    its('timeout_sec') { should eq https_health_check['timeout_sec'] }
    its('request_path') { should eq https_health_check['request_path'] }
    its('check_interval_sec') { should eq https_health_check['check_interval_sec'] }
    its('unhealthy_threshold') { should eq https_health_check['unhealthy_threshold'] }
  end

  describe google_compute_https_health_check(project: gcp_project_id, name: 'nonexistent') do
    it { should_not exist }
  end
end
