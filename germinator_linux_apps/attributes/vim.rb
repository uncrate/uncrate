case platform
when "debian", "ubuntu"
  default['vim']['package'] = "vim"
end