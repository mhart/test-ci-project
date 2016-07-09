#!/bin/bash -ex

# Clone an example Go repo
# This step obviously won't be necessary if you're building a Go repo with LambCI,
# because you'll already be in the cloned repo directory
rm -rf /tmp/toml
git clone --depth 1 https://github.com/BurntSushi/toml /tmp/toml
cd /tmp/toml


# Begin the Go bootstrapping process

VERSION=1.6.2

if ! [ -d $HOME/go ]; then
  curl -sSL https://storage.googleapis.com/golang/go${VERSION}.linux-amd64.tar.gz | tar -C $HOME -xz
fi

export GOROOT=$HOME/go
export PATH=$PATH:$GOROOT/bin

export GOPATH=$HOME/work
export PATH=$GOPATH/bin:$PATH

rm -rf $GOPATH

REPO_DIR=$PWD
mkdir -p $GOPATH/src/github.com/BurntSushi
cd $GOPATH/src/github.com/BurntSushi
mv $REPO_DIR ./toml
cd toml


# Now we can run our project's install and test steps

go install ./...
go get github.com/BurntSushi/toml-test
make test
