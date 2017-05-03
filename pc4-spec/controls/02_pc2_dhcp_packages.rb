# encoding: utf-8
# copyright: 2015, The Authors
# license: All rights reserved

title 'Router network for SA2 2017'

items = [ "isc-dhcp-server", "bind9"]
gateway = {
  device: "enp0s8",
  ip: "192.168.56.1"
}

# you add controls here
control 'packages-PC2-2.0' do                        # A unique ID for this control
  impact 0.7                                # The criticality, if this control fails.
  title 'DHCP Pakete auf PC2'             # A human-readable title
  desc 'An optional description...'

  describe package(items[0]) do
    it { should_not be_installed }
  end
  describe package(items[1]) do
    it { should be_installed }
  end
end
