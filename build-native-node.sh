#!/bin/bash -ex

# Clone an example native Node.js repo
# This step obviously won't be necessary if you're building a native Node.js repo with LambCI,
# because you'll already be in the cloned repo directory
rm -rf /tmp/hiredis-node
git clone --depth 1 https://github.com/redis/hiredis-node /tmp/hiredis-node
cd /tmp/hiredis-node

# This repo has submodules, so init them
# (you *will* have to do this step in your own repo if you have submodules)
git submodule update --init --recursive


# Begin the GCC bootstrapping process

curl -sSL https://lambci.s3.amazonaws.com/binaries/gcc-4.8.5.tgz | tar -C /tmp -xz

export PATH=/tmp/bin:/tmp/sbin:$PATH
export LD_LIBRARY_PATH=/usr/local/lib64/node-v4.3.x/lib:/tmp/lib:/tmp/lib64:/lib64:/usr/lib64:/var/runtime:/var/task:/var/task/lib
export CXX=/tmp/bin/g++
export CC=/tmp/bin/gcc
export CPATH=/tmp/include
export LIBRARY_PATH=/tmp/lib

# Now we can run our project's install and test steps

npm install
npm test
