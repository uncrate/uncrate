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
}.each do |os|
  supports os
end

depends "apt"
