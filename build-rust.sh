#!/bin/bash -ex

# Clone an example Rust repo
# This step obviously won't be necessary if you're building a Rust repo with LambCI,
# because you'll already be in the cloned repo directory
rm -rf /tmp/mio
git clone --depth 1 https://github.com/carllerche/mio /tmp/mio
cd /tmp/mio


# You could just put this in your `cmd` config property
. ~/init/rust && cargo build --verbose && cargo test --verbose
