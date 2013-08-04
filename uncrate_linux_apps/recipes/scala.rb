scala_tar_filename = File.basename(node['scala']['download_url'])
scala_tar_filepath = "#{Chef::Config['file_cache_path']}/#{scala_tar_filename}"
scala_extract_path = "#{Chef::Config['file_cache_path']}/scala/#{node['scala']['checksum']}"
scala_install_path = "#{node['scala']['install_path']}/#{node['scala']['install_dir']}"

include_recipe "ark"

ark node['scala']['install_dir'] do
  url node['scala']['download_url']
  path node['scala']['install_path']
  checksum node['scala']['checksum']
  mode 0755
  action :put
end

link "#{node['scala']['install_path']}/#{node['scala']['symlink_dir']}" do
  to scala_install_path
end

template "#{node['uncrate']['envdir']}/scala.sh" do
  source "scalaenv.sh.erb"
  mode "0755"
end