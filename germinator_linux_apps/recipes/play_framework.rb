include_recipe "germinator_linux_apps::unzip"

play_tar_filename = File.basename(node['play']['download_url'])
play_tar_filepath = "#{Chef::Config['file_cache_path']}/#{play_tar_filename}"
play_extract_path = "#{Chef::Config['file_cache_path']}/play/#{node['play']['checksum']}"
play_install_path = "#{node['play']['install_dir']}/#{File.basename(play_tar_filename, '.*')}"

remote_file play_tar_filepath do
  source node['play']['download_url']
  checksum node['play']['checksum']
  owner "root"
  group "root"
  mode "0644"
end

bash "extract play" do
  cwd ::File.dirname(play_tar_filepath)
  code <<-EOH
    mkdir -p #{play_extract_path}
    unzip #{play_tar_filename} -d #{play_extract_path}
    mkdir -p #{play_install_path}
    mv #{play_extract_path}/*/* #{play_install_path}
    chown -R #{node['germinator']['current_user']}:#{node['germinator']['current_user']} #{play_install_path}
  EOH

  not_if { ::File.exists?(play_install_path)}
end