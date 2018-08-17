#!/bin/bash -ex

# Clone an example Ruby repo
# This step obviously won't be necessary if you're building a Ruby repo with LambCI,
# because you'll already be in the cloned repo directory
rm -rf /tmp/http-2
git clone --depth 1 https://github.com/igrigorik/http-2 /tmp/http-2
cd /tmp/http-2


# You could just put this in your `cmd` config property
. ~/init/ruby && bundle install && bundle exec rake
