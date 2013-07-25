case platform
when "debian", "ubuntu"
  default['cinnamon']['package'] = "cinnamon"
end