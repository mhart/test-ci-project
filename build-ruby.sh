#!/bin/bash -ex

# Clone an example Ruby repo
# This step obviously won't be necessary if you're building a Ruby repo with LambCI,
# because you'll already be in the cloned repo directory
rm -rf /tmp/chunky_png
git clone --depth 1 https://github.com/wvanbergen/chunky_png /tmp/chunky_png
cd /tmp/chunky_png


# Begin the Ruby bootstrapping process

# All Ruby versions atm are:
# 2.3.1
# 2.2.5
# 2.1.9
# 2.0.0-p648
VERSION=2.3.1

# First grab libyaml and put it in our ~/usr/lib64 directory
curl -sSL https://lambci.s3.amazonaws.com/binaries/libyaml-2.0.4.tgz | tar -C ~ -xz

# Now install rbenv
if ! [ -d ~/.rbenv ]; then
  git clone --depth 1 https://github.com/rbenv/rbenv.git ~/.rbenv
fi
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# We don't need to install documentation with gems
echo "gem: --no-document" > ~/.gemrc

# We want pretty colors in our output
echo "--color --tty" > ~/.rspec

# Grab the Ruby version we want and install bundler
if ! [ -d ~/.rbenv/versions/$VERSION ]; then
  curl -sSL https://lambci.s3.amazonaws.com/binaries/ruby-${VERSION}.tgz | tar -C ~/.rbenv/versions -xz
  rbenv rehash
  rbenv local $VERSION
  gem install bundler
else
  rbenv local $VERSION
fi

# Ruby (and bundler) is now installed!


# Now we can run our project's install and test steps

bundle install
bundle exec rake

