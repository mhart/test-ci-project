#!/bin/bash -ex

# Clone an example Go repo
# This step obviously won't be necessary if you're building a Go repo with LambCI,
# because you'll already be in the cloned repo directory
export LAMBCI_REPO=emirpasic/gods
rm -rf /tmp/${LAMBCI_REPO}
git clone --depth 1 https://github.com/${LAMBCI_REPO} /tmp/${LAMBCI_REPO}
cd /tmp/${LAMBCI_REPO}


# You could just put this in your `cmd` config property
. ~/init/go && go get -t -v ./... && go test -v ./...

