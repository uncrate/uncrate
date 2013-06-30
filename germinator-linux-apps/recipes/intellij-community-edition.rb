template "/usr/share/applications/intellij-ce.desktop" do
	source "intellij-community-edition.desktop.erb"
	cookbook "germinator-linux-apps"
	owner node['current_user']
	mode "0777"
end

# TODO: Setup some attributes
intellij_mirror_site = "http://download.jetbrains.com/idea/ideaIC-12.1.4.tar.gz"
intellij_file = "ideaIC-12.1.4.tar.gz"
script "install_intellij_community_edition" do
  interpreter "bash"
  user "root"       
  cwd "/tmp/"
  code <<-EOH
  rm -rf /opt/intellij-ce
  wget #{intellij_mirror_site}
  tar -zxvf #{intellij_file}
  mv idea-IC* /opt/intellij-ce
  EOH
  only_if do ! File.exists?("/opt/intellij-ce/bin/idea.sh") end
end