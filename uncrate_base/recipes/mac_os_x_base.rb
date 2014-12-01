directory "/usr/local" do
  owner node['uncrate']['user']  
  group node['uncrate']['group']
  recursive true
end

include_recipe "homebrewalt"
