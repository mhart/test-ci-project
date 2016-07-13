#!/bin/bash -ex

# Clone an example Rust repo
# This step obviously won't be necessary if you're building a Rust repo with LambCI,
# because you'll already be in the cloned repo directory
rm -rf /tmp/mio
git clone --depth 1 https://github.com/carllerche/mio /tmp/mio
cd /tmp/mio


# Begin the Rust bootstrapping process

export CARGO_HOME=$HOME/.cargo
export MULTIRUST_HOME=$HOME/.multirust
export RUSTUP_HOME=$HOME/.multirust/rustup

curl https://sh.rustup.rs -sSf | sh -s -- -y

# Remove Rust docs to save space
rm -rf $RUSTUP_HOME/toolchains/stable-x86_64-unknown-linux-gnu/share

# Create symlinks from duped libs to save space
cd $RUSTUP_HOME/toolchains/stable-x86_64-unknown-linux-gnu/lib
for file in ./*; do
  if [ -f rustlib/x86_64-unknown-linux-gnu/lib/$file ]; then
    rm $file
    ln -s rustlib/x86_64-unknown-linux-gnu/lib/$file
  fi
done
cd -

export PATH=$HOME/.cargo/bin:$PATH

# Begin the GCC bootstrapping process

curl -sSL https://lambci.s3.amazonaws.com/binaries/gcc-4.8.5.tgz | tar -C /tmp -xz

export PATH=/tmp/bin:/tmp/sbin:$PATH
export LD_LIBRARY_PATH=/usr/local/lib64/node-v4.3.x/lib:/tmp/lib:/tmp/lib64:/lib64:/usr/lib64:/var/runtime:/var/task:/var/task/lib
export CPATH=/tmp/include
export LIBRARY_PATH=/tmp/lib


# Now we can run our project's install and test steps

cargo build --verbose --color=always
cargo test --verbose --color=always

du -k /tmp | sort -n
