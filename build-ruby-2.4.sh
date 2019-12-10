#!/bin/bash -ex

# Clone an example Ruby repo
# This step obviously won't be necessary if you're building a Ruby repo with LambCI,
# because you'll already be in the cloned repo directory
rm -rf /tmp/diff-lcs
git clone -b v1.3 --depth 1 https://github.com/halostatue/diff-lcs /tmp/diff-lcs
cd /tmp/diff-lcs


# Need this because of the native json extension
. ~/init/gcc

# You could just put this in your `cmd` config property
. ~/init/ruby 2.4.9 && bundle install && bundle exec rake
