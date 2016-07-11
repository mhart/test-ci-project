#!/bin/bash -ex

# Clone an example Java repo
# This step obviously won't be necessary if you're building a Java repo with LambCI,
# because you'll already be in the cloned repo directory
rm -rf /tmp/failsafe
git clone --depth 1 https://github.com/jhalterman/failsafe /tmp/failsafe
cd /tmp/failsafe


# Begin the Java bootstrapping process

export JAVA_HOME=/tmp/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.77-0.b03.9.amzn1.x86_64
export PATH=$JAVA_HOME/bin:$PATH
export _JAVA_OPTIONS=-Duser.home=$HOME

if ! [ -d $JAVA_HOME ]; then
  curl -sSL https://lambci.s3.amazonaws.com/binaries/java-1.8.0-openjdk-devel.tgz | tar -C /tmp -xz

  # For some reason, libjvm.so needs to be physically present
  # Can't symlink it, have to copy, but everything else can be symlinks
  cp -as /usr/lib/jvm/java-1.8*/jre $JAVA_HOME/
  rm $JAVA_HOME/jre/lib/amd64/server/libjvm.so
  cp /usr/lib/jvm/java-1.8*/jre/lib/amd64/server/libjvm.so $JAVA_HOME/jre/lib/amd64/server/
fi

# Also get Maven
if ! [ -d ~/apache-maven-3.3.9 ]; then
  curl -sSL http://www-us.apache.org/dist/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz | tar -xz -C ~
fi
export PATH=~/apache-maven-3.3.9/bin:$PATH


# Now we can run our project's install and test steps

mvn install -DskipTests=true -Dgpg.skip=true -Dmaven.javadoc.skip=true -B -V
mvn test jacoco:report

