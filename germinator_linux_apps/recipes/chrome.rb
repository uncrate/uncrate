chrome_package_filename = File.basename(node['chrome']['download_url'])
chrome_package_filepath = "#{Chef::Config['file_cache_path']}/#{chrome_package_filename}"

remote_file chrome_package_filepath do
  source node['chrome']['download_url']
  checksum node['chrome']['checksum']
  owner "root"
  group "root"
  mode "0644"
end

case node['platform_family']
when "debian"
  dpkg_package "Google chrome" do
    source chrome_package_filepath
  end
end