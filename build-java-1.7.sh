#!/bin/bash -ex

# Clone an example Java repo
# This step obviously won't be necessary if you're building a Java repo with LambCI,
# because you'll already be in the cloned repo directory
rm -rf /tmp/moshi
git clone --depth 1 https://github.com/square/moshi /tmp/moshi
cd /tmp/moshi


# Begin the Java bootstrapping process

# VERSION=1.8
VERSION=1.7

export JAVA_HOME=$(echo /tmp/usr/lib/jvm/java-${VERSION}.0-openjdk-${VERSION}*)

if ! [ -d $JAVA_HOME ]; then
  curl -sSL https://lambci.s3.amazonaws.com/binaries/java-${VERSION}.0-openjdk-devel.tgz | tar -C /tmp -xz

  # For some reason, libjvm.so needs to be physically present
  # Can't symlink it, have to copy, but everything else can be symlinks
  export JAVA_HOME=$(echo /tmp/usr/lib/jvm/java-${VERSION}.0-openjdk-${VERSION}*)
  cp -as /usr/lib/jvm/java-${VERSION}*/jre $JAVA_HOME/
  rm $JAVA_HOME/jre/lib/amd64/server/libjvm.so
  cp /usr/lib/jvm/java-${VERSION}*/jre/lib/amd64/server/libjvm.so $JAVA_HOME/jre/lib/amd64/server/
fi
export PATH=$JAVA_HOME/bin:$PATH
export _JAVA_OPTIONS=-Duser.home=$HOME

# Also get Maven
if ! [ -d ~/apache-maven-3.3.9 ]; then
  curl -sSL http://www-us.apache.org/dist/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz | tar -xz -C ~
fi
export PATH=~/apache-maven-3.3.9/bin:$PATH


# Now we can run our project's install and test steps

mvn install -DskipTests=true -Dmaven.javadoc.skip=true -B -V
mvn test

