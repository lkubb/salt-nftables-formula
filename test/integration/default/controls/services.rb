# frozen_string_literal: true

control 'nftables.service.running' do
  title 'The service should be installed, enabled and running'

  service_name = ''

  describe service(service_name) do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
  end
end
