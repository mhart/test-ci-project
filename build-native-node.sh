#!/bin/bash -ex

# Clone an example native Node.js repo
# This step obviously won't be necessary if you're building a native Node.js repo with LambCI,
# because you'll already be in the cloned repo directory
rm -rf /tmp/hiredis-node
git clone --depth 1 https://github.com/redis/hiredis-node /tmp/hiredis-node
cd /tmp/hiredis-node


# This repo has submodules, so init them before installing and testing
. ~/init/gcc && git submodule update --init --recursive && npm install && npm test

