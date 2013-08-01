android_sdk_tar_filename = File.basename(node['android_sdk']['download_url'])
android_sdk_tar_filepath = "#{Chef::Config['file_cache_path']}/#{android_sdk_tar_filename}"
android_sdk_extract_path = "#{Chef::Config['file_cache_path']}/android_sdk/#{node['android_sdk']['checksum']}"
android_sdk_install_path = "#{node['android_sdk']['install_dir']}/#{File.basename(android_sdk_tar_filename, '.*')}"

remote_file android_sdk_tar_filepath do
  source node['android_sdk']['download_url']
  checksum node['android_sdk']['checksum']
  owner "root"
  group "root"
  mode "0644"
end

bash "extract android_sdk" do
  cwd ::File.dirname(android_sdk_tar_filepath)
  code <<-EOH
    mkdir -p #{android_sdk_extract_path}
    tar zxf #{android_sdk_tar_filename} -C #{android_sdk_extract_path}
    mkdir -p #{android_sdk_install_path}
    mv #{android_sdk_extract_path}/*/* #{android_sdk_install_path}
    chown -R #{node['germinator']['current_user']}:#{node['germinator']['current_user']} #{android_sdk_install_path}
  EOH

  not_if { ::File.exists?(android_sdk_install_path)}
end

# ark "#{android_sdk_tar_filename}" do
#   url node['android_sdk']['download_url']
#   path node['android_sdk']['install_dir']
#   checksum node['android_sdk']['checksum']
#   owner "root"
#   group "root"
#   mode 0755
#   action :put
# end

if node['android_sdk']['include_tools']
  package = 'tools'
  execute "Install android package #{package}" do
    command "echo \"y\" | #{android_sdk_install_path}/tools/android update sdk -u --filter #{package}"
    user node['germinator']['current_user']
    group node['germinator']['current_user']
  end
end

if node['android_sdk']['include_platform_tools']
  package = 'platform-tools'
  execute "Install android package #{package}" do
    command "echo \"y\" | #{android_sdk_install_path}/tools/android update sdk -u --filter #{package}"
    user node['germinator']['current_user']
    group node['germinator']['current_user']
  end
end

if node['android_sdk']['include_build_tools']
  package = 'build-tools'
  execute "Install android package #{package}" do
    command "echo \"y\" | #{android_sdk_install_path}/tools/android update sdk -u --all --filter #{package}"
    user node['germinator']['current_user']
    group node['germinator']['current_user']
  end
end

# TODO: Create a LWRP for installing android packages
# android_platform "android platform #{android_version}" do
#   action :install
# end

versions = node['android_sdk']['versions']
if node['android_sdk']['include_platform']
  versions.each do |android_version|
    package = "android-#{android_version}"
    execute "Install android package #{package}" do
      command "echo \"y\" | #{android_sdk_install_path}/tools/android update sdk -u --filter #{package}"
      user node['germinator']['current_user']
      group node['germinator']['current_user']
    end
  end
end

if node['android_sdk']['include_add_ons']
  versions.each do |android_version|
    package = "addon-google_apis-google-#{android_version}"
    execute "Install android package #{package}" do
      command "echo \"y\" | #{android_sdk_install_path}/tools/android update sdk -u --filter #{package}"
      user node['germinator']['current_user']
      group node['germinator']['current_user']
    end
  end
end

if node['android_sdk']['include_docs']
  versions.each do |android_version|
    package = "doc-#{android_version}"
    execute "Install android package #{package}" do
      command "echo \"y\" | #{android_sdk_install_path}/tools/android update sdk -u --all --filter #{package}"
      user node['germinator']['current_user']
      group node['germinator']['current_user']
    end
  end
end

if node['android_sdk']['include_source']
  versions.each do |android_version|
    package = "source-#{android_version}"
    execute "Install android package #{package}" do
      command "echo \"y\" | #{android_sdk_install_path}/tools/android update sdk -u --all --filter #{package}"
      user node['germinator']['current_user']
      group node['germinator']['current_user']
    end
  end
end

if node['android_sdk']['include_system_image']
  versions.each do |android_version|
    package = "sysimg-#{android_version}"
    execute "Install android package #{package}" do
      command "echo \"y\" | #{android_sdk_install_path}/tools/android update sdk -u --all --filter #{package}"
      user node['germinator']['current_user']
      group node['germinator']['current_user']
    end
  end
end

if node['android_sdk']['include_sample']
  versions.each do |android_version|
    package = "sample-#{android_version}"
    execute "Install android package #{package}" do
      command "echo \"y\" | #{android_sdk_install_path}/tools/android update sdk -u --all --filter #{package}"
      user node['germinator']['current_user']
      group node['germinator']['current_user']
    end
  end
end
