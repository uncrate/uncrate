case node['platform']
when "ubuntu"
  # add the cinnamon PPA
  apt_repository "cinnamon-stable" do
    uri "http://ppa.launchpad.net/gwendal-lebihan-dev/cinnamon-stable/ubuntu"
    distribution node['lsb']['codename']
    components ["main"]
    action :add
    keyserver "keyserver.ubuntu.com"
    key "28949509"
  end

  package "cinnamon" do
    package_name node['cinnamon']['package']
  end
end
