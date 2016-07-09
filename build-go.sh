#!/bin/bash -ex

# Clone an example Go repo
# This step obviously won't be necessary if you're building a Go repo with LambCI,
# because you'll already be in the cloned repo directory
rm -rf /tmp/hob
git clone --depth 1 https://github.com/mrb/hob /tmp/hob
cd /tmp/hob


# Begin the Go bootstrapping process

VERSION=1.6.2

if ! [ -d $HOME/go ]; then
  curl -sSL https://storage.googleapis.com/golang/go${VERSION}.linux-amd64.tar.gz | tar -C $HOME -xz
fi

export GOROOT=$HOME/go
export PATH=$PATH:$GOROOT/bin

export GOPATH=$PWD


# Now we can run our project's install and test steps

go get github.com/bmizerany/assert
go get github.com/mrb/hob
go test

