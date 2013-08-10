name             'Uncrate_base'
maintainer       'John Leacox'
license          'Apache 2'
description      'Base things needed by all Uncrate recipes'
version          '0.1.0'
supports         'Linux'

case platform
when "debian", "ubuntu"
  depends "apt"
when "centos, redhat"
end