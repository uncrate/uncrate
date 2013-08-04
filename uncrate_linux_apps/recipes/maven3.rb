maven_tar_filename = File.basename(node['maven']['download_url'])
maven_tar_filepath = "#{Chef::Config['file_cache_path']}/#{maven_tar_filename}"
maven_extract_path = "#{Chef::Config['file_cache_path']}/maven/#{node['maven']['checksum']}"
maven_install_path = "#{node['maven']['install_path']}/#{node['maven']['install_dir']}"

include_recipe "ark"

ark node['maven']['install_dir'] do
  url node['maven']['download_url']
  path node['maven']['install_path']
  checksum node['maven']['checksum']
  # owner node['uncrate']['user']
  # group node['uncrate']['user']
  mode 0755
  action :put
end

link "#{node['maven']['install_path']}/#{node['maven']['symlink_dir']}" do
  to maven_install_path
  # owner node['uncrate']['user']
  # group node['uncrate']['user']
end

template "#{node['uncrate']['envdir']}/maven.sh" do
  source "mavenenv.sh.erb"
  # owner node['uncrate']['user']
  # group node['uncrate']['user']
  mode "0755"
end