#!/bin/bash -ex

# Clone an example Ruby repo
# This step obviously won't be necessary if you're building a Ruby repo with LambCI,
# because you'll already be in the cloned repo directory
rm -rf /tmp/chunky_png
git clone --depth 1 https://github.com/wvanbergen/chunky_png /tmp/chunky_png
cd /tmp/chunky_png


export LD_LIBRARY_PATH=$HOME/usr/lib64:$LD_LIBRARY_PATH

# You could just put this in your `cmd` config property
. ~/init/ruby && bundle install && bundle exec rake

