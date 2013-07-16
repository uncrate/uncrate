default['chrome']['deb64_download_url'] = 'https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb'
default['chrome']['deb64_checksum'] = '55e2f0d24dca57c2e4c0b81859ba902646436aebd044779353a3eeea1a0d846a'

default['chrome']['deb32_download_url'] = 'https://dl.google.com/linux/direct/google-chrome-stable_current_i386.deb'
default['chrome']['deb32_checksum'] = '0c1241d1c0ae56298142b9a8bacd7e43097179effafe39184735aa738f6e9dff'

arch = node['kernel']['machine'] =~ /x86_64/ ? "x86_64" : "i386"

case node['platform_family']
when "debian"
  if arch == "x86_64"
    default['chrome']['download_url'] = node['chrome']['deb64_download_url']
    default['chrome']['checksum'] = node['chrome']['deb64_checksum']
  else
    default['chrome']['download_url'] = node['chrome']['deb32_download_url']
    default['chrome']['checksum'] = node['chrome']['deb632_checksum']
  end
end
