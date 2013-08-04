sublime_text_tar_filename = File.basename(node['sublime_text']['download_url'])
sublime_text_tar_filepath = "#{Chef::Config['file_cache_path']}/#{sublime_text_tar_filename}"
sublime_text_extract_path = "#{Chef::Config['file_cache_path']}/sublime_text/#{node['sublime_text']['checksum']}"
sublime_text_install_path = "#{node['sublime_text']['install_path']}/#{node['sublime_text']['install_dir']}"

include_recipe "ark"

ark node['sublime_text']['install_dir'] do
  url node['sublime_text']['download_url']
  path node['sublime_text']['install_path']
  checksum node['sublime_text']['checksum']
  mode 0755
  action :put
end

template "/usr/share/applications/#{node['sublime_text']['shortcut_name']}.desktop" do
  source "sublime_text.desktop.erb"
  cookbook "uncrate_linux_apps"
  mode "0644"
end

link "/usr/local/bin/#{node['sublime_text']['shortcut_name']}" do
  to "#{sublime_text_install_path}/sublime_text"
end