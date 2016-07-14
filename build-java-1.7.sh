#!/bin/bash -ex

# Clone an example Java repo
# This step obviously won't be necessary if you're building a Java repo with LambCI,
# because you'll already be in the cloned repo directory
rm -rf /tmp/moshi
git clone --depth 1 https://github.com/square/moshi /tmp/moshi
cd /tmp/moshi


# You could just put this in your `cmd` config property
. ~/init/java 1.7 && mvn install -DskipTests=true -Dmaven.javadoc.skip=true -B -V && mvn test

