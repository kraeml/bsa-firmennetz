# encoding: utf-8
# copyright: 2015, The Authors
# license: All rights reserved

title 'Router network for SA2 2017'

pcs = {
  pc1: {
    hostname: "server01",
    hostname_fqdn: "server01.firma09.com",
    ip: "192.168.109.2"
  },
  pc2: {
    hostname: "server01",
    hostname_fqdn: "server02.firma09.com",
    ip: "192.168.109.3"
  },
  pc3: {
    hostname: "server01",
    hostname_fqdn: "client01.firma09.com",
    ip: "192.168.109.4"
  },
  pc4: {
    hostname: "server01",
    hostname_fqdn: "client02.firma09.com",
    ip: "192.168.109.20"
  }
}

# you add controls here
control 'network-PC2-3.0' do                        # A unique ID for this control
  impact 0.7                                # The criticality, if this control fails.
  title 'Ping the network'             # A human-readable title
  desc 'An optional description...'
  pcs.each do |pc_key, pc_value|
    describe host(pc_value[:ip]) do
      it { should be_reachable }
    end
  end
end
