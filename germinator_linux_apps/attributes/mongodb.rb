case platform
when "debian", "ubuntu"
  default['mongodb']['package'] = "mongodb-10gen"
end