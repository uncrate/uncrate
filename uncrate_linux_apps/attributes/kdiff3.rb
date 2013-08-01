case platform
when "debian", "ubuntu"
  default['kdiff3']['package'] = "kdiff3"
end