require "chef-sudo"

case node['platform']
when "ubuntu"
  package "zsh" do
    package_name node['zsh']['package']
  end
end

case node['platform']
when "ubuntu"     
  execute "Install oh-my-zsh" do
    command <<-EOF
      git clone git://github.com/robbyrussell/oh-my-zsh.git #{node['germinator']['home']}/.oh-my-zsh
      cp #{node['germinator']['home']}/.zshrc #{node['germinator']['home']}/.zshrc.orig
      cp #{node['germinator']['home']}/.oh-my-zsh/templates/zshrc.zsh-template #{node['germinator']['home']}/.zshrc
    EOF
    user node['germinator']['current_user']
    not_if { File.exist?("#{node['germinator']['home']}/.oh-my-zsh") }
  end

  sudo "Set zsh to default shell (requires logout/login)" do
    command "chsh -s `which zsh` #{node['germinator']['current_user']}"
  end
else
  execute "Install oh-my-zsh" do
    command "curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh"
    user node['germinator']['current_user']
    not_if { File.exist?("#{node['germinator']['home']}/.oh-my-zsh") }
  end
end