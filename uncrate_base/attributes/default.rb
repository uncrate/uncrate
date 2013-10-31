default['uncrate']['user'] = nil
default['uncrate']['home'] = "/opt/uncrate"
default['uncrate']['envdir'] = "#{node['uncrate']['home']}/env.d"

case platform
when "debian", "ubuntu", "centos", "redhat"
  default['vim']['package'] = "vim"
end

case platform
when "debian", "ubuntu", "centos", "redhat"
  default['uncrate']['group'] = node['uncrate']['user']
when "mac_os_x"
  default['uncrate']['group'] = 'staff'
end