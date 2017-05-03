# encoding: utf-8
# copyright: 2015, The Authors
# license: All rights reserved

title 'Router network for SA2 2017'

items = [ "net.ipv4.ip_forward"]
gateway = {
  device: "enp0s8",
  ip: "192.168.56.1"
}

# you add controls here
control 'network-PC1-2.0' do                        # A unique ID for this control
  impact 0.7                                # The criticality, if this control fails.
  title 'NAT and IP forward enabled'             # A human-readable title
  desc 'An optional description...'
  items.each do |item|
    describe kernel_parameter(item) do
      its('value') { should eq 1 }
    end
  end
  #describe iptables(table:'nat', chain: 'POSTROUTING') do
  #  it { should have_rule('MASQUERADE') }
  #end
  describe command('sudo iptables -t nat -S') do
    its('stdout') { should match (/^-A POSTROUTING -o #{gateway[:device]} -j MASQUERADE$/) }
  end
  describe command('sudo ip route show') do
    its('stdout') { should match (/^default via #{gateway[:ip]} dev #{gateway[:device]}/)}
  end
  #describe iptables do
  #  it { should have_rule('-j MASQUERADE').with_table('nat').with_chain('POSTROUTING') }
  #end
end
