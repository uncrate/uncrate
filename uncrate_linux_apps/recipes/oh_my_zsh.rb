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
      git clone git://github.com/robbyrussell/oh-my-zsh.git #{node['uncrate']['user_home']}/.oh-my-zsh
      cp #{node['uncrate']['user_home']}/.zshrc #{node['uncrate']['user_home']}/.zshrc.orig
      cp #{node['uncrate']['user_home']}/.oh-my-zsh/templates/zshrc.zsh-template #{node['uncrate']['user_home']}/.zshrc
    EOF
    user node['uncrate']['user']
    not_if { File.exist?("#{node['uncrate']['user_home']}/.oh-my-zsh") }
  end

  sudo "Set zsh to default shell (requires logout/login)" do
    command "chsh -s `which zsh` #{node['uncrate']['user']}"
  end
else
  execute "Install oh-my-zsh" do
    command "curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh"
    user node['uncrate']['user']
    not_if { File.exist?("#{node['uncrate']['user_home']}/.oh-my-zsh") }
  end
end