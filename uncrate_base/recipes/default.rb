if node['uncrate']['user'].nil?
  Chef::Application.fatal!("The node['uncrate']['user'] must be set")
end

#node.default['uncrate']['current_user_home'] = node['etc']['passwd'][node['uncrate']['user']]['dir']
node.default['uncrate']['user_home'] = node['etc']['passwd'][node['uncrate']['user']]['dir']