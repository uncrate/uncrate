intellij_tar_filename = File.basename(node['intellij_community_edition']['download_url'])
intellij_tar_filepath = "#{Chef::Config['file_cach_path']}/#{intellij_tar_filename}"
intellij_extract_path = "#{Chef::Config['file_cach_path']}/intellij_community_edition/#{node['intellij_community_edition']['checksum']}"

remote_file intellij_tar_filepath do
  source node['intellij_community_edition']['download_url']
  checksum node['intellij_community_edition']['checksum']
  owner "root"
  group "root"
  mode "0644"
end

bash "extract_intellij_community_edition" do
  cwd ::File.dirname(intellij_tar_filepath)
  code <<-EOH
    mkdir -p #{intellij_extract_path}
    tar zxf #{intellij_tar_filename} -C #{intellij_extract_path}
    mkdir -p #{node['intellij_community_edition']['install_path']}
    mv #{intellij_extract_path}/*/* #{node['intellij_community_edition']['install_path']}/
  EOH

  not_if { ::File.exists?(node['intellij_community_edition']['install_path'])}
end

template "/usr/share/applications/#{node['intellij_community_edition']['shortcut_name']}.desktop" do
  source "intellij_community_edition.desktop.erb"
  cookbook "germinator_linux_apps"
  owner node['current_user']
  mode "0755"
end

# TODO: Setup some attributes
# intellij_mirror_site = "http://download.jetbrains.com/idea/ideaIC-12.1.4.tar.gz"
# intellij_file = "ideaIC-12.1.4.tar.gz"
# script "install_intellij_community_edition" do
#   interpreter "bash"
#   user "root"       
#   cwd "/tmp/"
#   code <<-EOH
#   rm -rf /opt/intellij-ce
#   wget #{node[:intellij_community_edition_download_uri]}
#   tar -zxvf #{intellij_file}
#   mv idea-IC* /opt/intellij-ce
#   EOH
#   only_if do ! File.exists?("/opt/intellij-ce/bin/idea.sh") end
# end