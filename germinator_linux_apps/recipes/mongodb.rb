case node['platform']
when "ubuntu"
  # add the mongodb PPA
  apt_repository "mongodb" do
    uri "http://downloads-distro.mongodb.org/repo/ubuntu-upstart"
    components ["dist", "10gen"]
    keyserver "keyserver.ubuntu.com"
    key "7F0CEB10"
  end

  package "mongodb" do
    package_name node['mongodb']['package']
  end

  service "mongodb" do
    case node['platform_family']
    when "debian"
      service_name "mongodb"
      restart_command "service mongodb restart"
    end
    supports [:restart, :status]
    action [:enable, :start]
  end
end