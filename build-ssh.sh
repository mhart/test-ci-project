#!/bin/bash -ex

# Clone a repo using ssh – this is not probably something you'll want to do directly,
# but may be something you'll need to setup for submodules.

# This private key is stored in secretEnv.GITHUB_RSA_KEY
# In this case it's a deploy key that only has read access to the repo
# If you install the lambci CLI tool, you can do a similar thing like this:
# lambci config --project gh/mhart/test-ci-project secretEnv.GITHUB_RSA_KEY "$(cat ./id_rsa)"
set +x
echo "$GITHUB_RSA_KEY" > ./id_rsa
chmod 600 ./id_rsa
set -x

export GIT_SSH_COMMAND="ssh -i ./id_rsa -o UserKnownHostsFile=./known_hosts"

rm -rf /tmp/test-ci-project
git clone --depth 1 git@github.com:mhart/test-ci-project.git /tmp/test-ci-project
cd /tmp/test-ci-project

npm install && npm test
