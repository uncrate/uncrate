case platform
when "debian", "ubuntu"
  default['zsh']['package'] = "zsh"
end