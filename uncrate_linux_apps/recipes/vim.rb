case node['platform']
when "ubuntu"
  package "vim" do
    package_name node['vim']['package']
  end
end