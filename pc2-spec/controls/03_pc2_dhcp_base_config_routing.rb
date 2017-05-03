# encoding: utf-8
# copyright: 2015, The Authors
# license: All rights reserved

title 'Router network for SA2 2017'

items = [ "isc-dhcp-server", "bind9"]
dhcp_conf = {
  dhcp_ip: "192.168.109.3",
  mask: "255.255.255.0",
  router: "192.168.109.2",
  dns: "192.168.109.4",
  domain: "firma09.com",
  device: "enp0s8",
  user_key: "DHCP_UPDATER",
  algorithm: "algorithm HMAC-MD5.SIG-ALG.REG.INT;",
  secret: 'secret ".*";', # 24 Zeichen lothZytX9qVHhN1fPi3gBg==,
  conf: {
    include: 'include "/etc/dhcp/ddns.key";',
    style: "ddns-update-style interim;",
    ddns_domain: 'ddns-domainname "firma09.com";',
    ignore: "ignore client-updates;",
    domain: 'option domain-name "firma09.com";',
    dns: "option domain-name-servers 192.168.109.4;",
    d_leas: "default-lease-time 600;",
    m_leas: "max-lease-time 7200;",
    authoritative: "authoritative;",
    range: "range 192.168.109.20 192.168.109.50;",
    f_zone: "zone firma09.com. {",
    primary: "primary 192.168.109.4;",
    key: "key DHCP_UPDATER;",
    r_zone: "zone 109.168.192.in-addr.arpa. {"
  }
}

# you add controls here
control 'dhcp-PC2-2.0' do                        # A unique ID for this control
  impact 0.7                                # The criticality, if this control fails.
  title 'DHCP Konfiguration auf PC2'             # A human-readable title
  desc 'An optional description...'
  describe command("sudo nmap --script broadcast-dhcp-discover -e #{dhcp_conf[:device]}") do
    its('stdout') { should match /Server Identifier: #{dhcp_conf[:dhcp_ip]}/ }
    its('stdout') { should match /Subnet Mask: #{dhcp_conf[:mask]}/ }
    its('stdout') { should match /Router: #{dhcp_conf[:router]}/ }
    its('stdout') { should match /Domain Name Server: #{dhcp_conf[:dns]}/ }
    its('stdout') { should match /Domain Name: #{dhcp_conf[:domain]}/ }
  end
  describe file('/etc/default/isc-dhcp-server') do
    its(:content) { should match /^INTERFACES="#{dhcp_conf[:device]}"/ }
  end
  describe file('/etc/dhcp/ddns.key') do
    its(:content) { should match /key\s*#{dhcp_conf[:user_key]}/ }
    its(:content) { should match /#{dhcp_conf[:algorithm]}/ }
    its(:content) { should match /#{dhcp_conf[:secret]}/ }
    its(:content) { should match /};/ }
  end
  dhcp_conf[:conf].each do |key, value|
    describe file('/etc/dhcp/dhcpd.conf') do
      its(:content) { should match /#{value}/ }
    end
  end
end
