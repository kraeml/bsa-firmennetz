# encoding: utf-8
# copyright: 2015, The Authors
# license: All rights reserved

title 'sample section'

nameserver = "192.168.109.4"
interface_items = {
  :enp0s3 => {
    :ip => "10.0.2.15",
    :net => "/24"
  },
  :enp0s8 => {
    :ip => "192.168.109.3",
    :net => "/24"
  }
}
net = {
  router: "192.168.109.2",
  device: "enp0s8"
}
search_itmes = [ "firma09.com", "rdf.loc" ]
name_items = [ "server02", "server02." + search_itmes[0] ]


# you add controls here
control 'network-PC2-1.0' do                        # A unique ID for this control
  impact 0.7                                # The criticality, if this control fails.
  title 'Hostname, resolv.conf, ip mit mask'             # A human-readable title
  desc 'An optional description...'
  describe command('ip route show') do
    its(:stdout) { should match /default via #{net[:router]} dev #{net[:device]}/ }
  end
  name_items.each do |item|
    describe host(item) do
      it { should be_reachable }
      its('ipaddress') { should include '127.0.0.2' }
    end
  end
  describe command('hostname') do
    its('stdout') { should eq name_items[0]+"\n"}
  end
  describe file('/etc/resolv.conf') do
    it { should_not be_symlink }
    its('content') { should match '^nameserver\s+' + nameserver + '$' }
    search_itmes.each do |item|
      its('content') { should match '^search\s+.*' + item }
    end
    its('content') { should_not match '^nameserver 10.\d*.\d*.\d*$' }
  end
  interface_items.each do |key, value|
    describe interface(key) do
      it { should be_up }
      #its('address') { should eq '192.168.55.66'}
    #  its('speed') { should eq 1000 }
    #  its('name') { should eq 'enp0s3' }
    end
    describe command("ip addr | grep 'state UP' -A2 | grep -v -- '^--$' | grep #{key} | tail -n1 | awk '{print $2}'") do
      its('stdout') { should eq value[:ip] + value[:net] + "\n" }
    end
  end
  # ip = command("ip addr | grep 'state UP' -A2 | grep 'enp0s3' -A1 | tail -n2 | awk '{print $2}' | head -n1 | cut -f1  -d'/'").stdout.strip
end
