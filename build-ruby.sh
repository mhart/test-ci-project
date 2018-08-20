#!/bin/bash -ex

# Clone an example Ruby repo
# This step obviously won't be necessary if you're building a Ruby repo with LambCI,
# because you'll already be in the cloned repo directory
rm -rf /tmp/diff-lcs
git clone -b v1.3 --depth 1 https://github.com/halostatue/diff-lcs /tmp/diff-lcs
cd /tmp/diff-lcs


# You could just put this in your `cmd` config property
. ~/init/ruby && bundle install && bundle exec rake
