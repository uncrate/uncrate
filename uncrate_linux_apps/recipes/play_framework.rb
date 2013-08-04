play_tar_filename = File.basename(node['play']['download_url'])
play_tar_filepath = "#{Chef::Config['file_cache_path']}/#{play_tar_filename}"
play_extract_path = "#{Chef::Config['file_cache_path']}/play/#{node['play']['checksum']}"
play_install_path = "#{node['play']['install_path']}/#{node['play']['install_dir']}"

include_recipe "ark"

ark node['play']['install_dir'] do
  url node['play']['download_url']
  path node['play']['install_path']
  checksum node['play']['checksum']
  owner node['uncrate']['user']
  group node['uncrate']['user']
  mode 0755
  action :put
end

link "#{node['play']['install_path']}/#{node['play']['symlink_dir']}" do
  to play_install_path
end

template "#{node['uncrate']['envdir']}/play.sh" do
  source "playenv.sh.erb"
  mode "0755"
end