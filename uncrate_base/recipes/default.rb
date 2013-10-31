if node['uncrate']['user'].nil?
  Chef::Application.fatal!("The node['uncrate']['user'] attribute must be set")
end

node.default['uncrate']['user_home'] = node['etc']['passwd'][node['uncrate']['user']]['dir']

template "#{node['uncrate']['home']}/env.sh" do
  source "env.sh.erb"
  owner node['uncrate']['user']
  group node['uncrate']['group']
  mode "0755"
end

directory node['uncrate']['home'] do
  owner node['uncrate']['user']
  group node['uncrate']['group']
  mode "0755"
end

directory node['uncrate']['envdir'] do
  owner node['uncrate']['user']
  group node['uncrate']['group']
  mode "0755"
end

case node['platform']
when "debian", "ubuntu"
  include_recipe "uncrate_base::ubuntu_base"
when "centos", "redhat"
when "mac_os_x"
  include_recipe "uncrate_base::mac_os_x_base"
end
