case platform
when "debian", "ubuntu"
  default['unzip']['package'] = "unzip"
end