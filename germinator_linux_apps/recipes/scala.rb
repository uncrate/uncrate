scala_tar_filename = File.basename(node['scala']['download_url'])
scala_tar_filepath = "#{Chef::Config['file_cache_path']}/#{scala_tar_filename}"
scala_extract_path = "#{Chef::Config['file_cache_path']}/scala/#{node['scala']['checksum']}"
scala_install_path = "#{node['scala']['install_dir']}/#{File.basename(scala_tar_filename, '.*')}"

remote_file scala_tar_filepath do
  source node['scala']['download_url']
  checksum node['scala']['checksum']
  owner "root"
  group "root"
  mode "0644"
end

bash "extract scala" do
  cwd ::File.dirname(scala_tar_filepath)
  code <<-EOH
    mkdir -p #{scala_extract_path}
    tar zxf #{scala_tar_filename} -C #{scala_extract_path}
    mkdir -p #{scala_install_path}
    mv #{scala_extract_path}/* #{scala_install_path}
  EOH

  not_if { ::File.exists?(scala_install_path)}
end

link "/usr/bin/scala" do
  to "#{scala_install_path}/bin/scala"
end

link "/usr/bin/scalac" do
  to "#{scala_install_path}/bin/scalac"
end

link "/usr/bin/scaladoc" do
  to "#{scala_install_path}/bin/scaladoc"
end

link "/usr/bin/scalap" do
  to "#{scala_install_path}/bin/scalap"
end

link "/usr/bin/fsc" do
  to "#{scala_install_path}/bin/fsc"
end