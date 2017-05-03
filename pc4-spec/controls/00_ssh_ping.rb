# encoding: utf-8
# copyright: 2015, The Authors
# license: All rights reserved

title 'sample section'

interface_items = {
  :enp0s3 => {
    :ip => "10.0.2.15",
    :net => "/24"
  },
  :enp0s8 => {
    :ip => "192.168.109.4",
    :net => "/24"
  }
}
control 'network-PC2-0.0' do                        # A unique ID for this control
  impact 0.7                                # The criticality, if this control fails.
  title 'SSH ping'             # A human-readable title
  desc 'An optional description...'
  describe host(interface_items[:enp0s8][:ip], port: 22, proto: 'tcp') do
    it { should be_reachable }
  end
end
