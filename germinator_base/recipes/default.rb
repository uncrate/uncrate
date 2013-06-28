if node['germinator']['current_user'].nil?
  Chef::Application.fatal!("The node['germinator']['current_user'] must be set")
end

node.default['germinator']['current_user_home'] = node['etc']['passwd'][node['germinator']['current_user']]['dir']
node.default['germinator']['home'] = node['germinator']['current_user_home']