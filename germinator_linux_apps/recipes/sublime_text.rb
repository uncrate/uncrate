sublime_text_tar_filename = File.basename(node['sublime_text']['download_url'])
sublime_text_tar_filepath = "#{Chef::Config['file_cache_path']}/#{sublime_text_tar_filename}"
sublime_text_extract_path = "#{Chef::Config['file_cache_path']}/sublime_text/#{node['sublime_text']['checksum']}"

remote_file sublime_text_tar_filepath do
  source node['sublime_text']['download_url']
  checksum node['sublime_text']['checksum']
  owner "root"
  group "root"
  mode "0644"
end

bash "extract_sublime_text" do
  cwd ::File.dirname(sublime_text_tar_filepath)
  code <<-EOH
    mkdir -p #{sublime_text_extract_path}
    tar jxvf #{sublime_text_tar_filename} -C #{sublime_text_extract_path}
    mkdir -p #{node['sublime_text']['install_path']}
    mv #{sublime_text_extract_path}/*/* #{node['sublime_text']['install_path']}/
  EOH

  not_if { ::File.exists?(sublime_text_extract_path)}
end

template "/usr/share/applications/#{node['sublime_text']['shortcut_name']}.desktop" do
  source "sublime_text.desktop.erb"
  cookbook "germinator_linux_apps"
  owner node['current_user']
  mode "0755"
end

link "/usr/local/bin/#{node['sublime_text']['shortcut_name']}" do
  to "#{node['sublime_text']['install_path']}/sublime_text"
end