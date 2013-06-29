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

sudo apt-get install build-essential git-core curl

# Install RVM
if ! hash rvm &>/dev/null ; then
	bash -s stable < <(curl -s https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer)
	echo  '[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"  # Load RVM into a shell session *as a function*' >> "$HOME/.bashrc"

	source ~/.rvm/scripts/rvm
	source ~/.bashrc
fi

# Install Ruby
rvm install 2.0.0
rvm --default use 2.0.0

# Install soloist (chef-solo)
sudo gem install soloist
