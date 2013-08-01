#!/bin/bash

# Copyright 2013 John Leacox
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

if [ "$(whoami)" = "root" ]; then
	echo -e "Run script as a non-root user and without sudo\n"
	exit 1
fi

export DEBIAN_FRONTEND=noninteractive
sudo apt-get update
sudo apt-get -q -y install build-essential git-core curl

# Install RVM
if ! hash rvm &>/dev/null ; then
	echo -e "Installing RVM\n"
	bash -s stable < <(curl -s https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer)
	echo  '[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"' >> "$HOME/.bashrc"

	echo -e "Sourcing RVM\n"
	source ~/.rvm/scripts/rvm
	source ~/.bashrc
fi

# Install Ruby
echo -e "Installing Ruby\n"
rvm install 1.9.3
rvm --default use 1.9.3

# Install bundler
echo -e "Installing bundler"
gem install bundler

if [[ -d uncrate ]]; then
  cd uncrate && git pull
else
  git clone https://github.com/johnlcox/uncrate.git
  cd uncrate && git checkout master
fi

# Bundle and execute soloist
echo -e "Running soloist"
bundle
bundle exec soloist
