# frozen_string_literal: true

control 'nftables.package.install' do
  title 'The required package should be installed'

  package_name = 'nftables'

  describe package(package_name) do
    it { should be_installed }
  end
end
