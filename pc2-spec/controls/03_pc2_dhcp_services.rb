# encoding: utf-8
# copyright: 2015, The Authors
# license: All rights reserved

title 'Router network for SA2 2017'

items = [ "isc-dhcp-server", "bind9"]

# you add controls here
control 'services-PC2-2.0' do                        # A unique ID for this control
  impact 0.7                                # The criticality, if this control fails.
  title 'DHCP Service auf PC2'             # A human-readable title
  desc 'An optional description...'
  describe service(items[0]) do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
  end
end
