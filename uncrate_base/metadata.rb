name             'Uncrate_base'
maintainer       'John Leacox'
license          'Apache 2'
description      'Base things needed by all Uncrate recipes'
version          '0.1.0'

%w{
  debian
  ubuntu
  centos
  redhat
  mac_os_x
}.each do |os|
  supports os
end

depends "apt"
depends "yum"
depends "homebrew"
