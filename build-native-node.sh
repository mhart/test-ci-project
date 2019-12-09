#!/bin/bash -ex

# Clone an example native Node.js repo
# This step obviously won't be necessary if you're building a native Node.js repo with LambCI,
# because you'll already be in the cloned repo directory
rm -rf /tmp/node.bcrypt.js
git clone --depth 1 https://github.com/kelektiv/node.bcrypt.js -b v3.0.7 /tmp/node.bcrypt.js
cd /tmp/node.bcrypt.js


# We need to install gcc before we test
. ~/init/gcc && npm test

