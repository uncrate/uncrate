maven_tar_filename = File.basename(node['maven']['download_url'])
maven_tar_filepath = "#{Chef::Config['file_cache_path']}/#{maven_tar_filename}"
maven_extract_path = "#{Chef::Config['file_cache_path']}/maven/#{node['maven']['checksum']}"
maven_install_path = node['maven']['install_dir'] #/#{File.basename(maven_tar_filename, '.*')}"

remote_file maven_tar_filepath do
  source node['maven']['download_url']
  checksum node['maven']['checksum']
  owner node['uncrate']['user']
  group node['uncrate']['user']
  mode "0644"
end

bash "extract maven" do
  cwd ::File.dirname(maven_tar_filepath)
  code <<-EOH
    mkdir -p #{maven_extract_path}
    tar zxf #{maven_tar_filename} -C #{maven_extract_path}
    mkdir -p #{maven_install_path}
    mv #{maven_extract_path}/* #{maven_install_path}
  EOH
end

template "#{node['uncrate']['envdir']}/maven.sh" do
	source "mavenenv.sh.erb"
	owner node['uncrate']['user']
	mode "0755"
end