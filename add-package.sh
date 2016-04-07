#!/bin/bash

set -e

# USAGE:  add-package.sh [NAME]
# will create org.cmyers.test.NAME in ROOT/NAME

if [[ -d $1 ]]; then
    echo "$1 already exists in PWD, exiting"
    exit 1;
fi

cp -r test-template $1

qbt addPackage --repo org.cmyers.test --package org.cmyers.test.$1
qbt updatePackage --package org.cmyers.test.$1 --prefix $1 --addQbtEnv JDK=1_8 --addNormalDependency Weak 3p.gradle --addNormalDependency Weak qbt_fringe.linter.release --addNormalDependency Strong mc.junit.junit
qbt addPackage --repo org.cmyers.test --package org.cmyers.test.$1.release
qbt updatePackage --package org.cmyers.test.$1.release --prefix $1 --addQbtEnv JDK=1_8 --addNormalDependency Weak org.cmyers.test.$1 --addNormalDependency Weak qbt_fringe.wrapper_generator.release

echo "To add Guava:"
echo "    qbt updatePackage --package org.cmyers.test.$1 --addNormalDependency Strong mc.com.google.guava.guava"
echo ""
echo "To add misc1 concurrency lib:"
echo "    qbt updatePackage --package org.cmyers.test.$1 --addNormalDependency Strong misc1.commons.concurrent.main"
echo ""
echo "To generate eclipse/idea files:"
echo "    qbt devProto --proto eclipse-gen --package org.cmyers.test.$1"

#mkdir -p q$1/src/org/cmyers/euler/q$1
#echo "package org.cmyers.euler.q$1;" >> q$1/src/org/cmyers/euler/q$1/Main.java
#echo "" >> q$1/src/org/cmyers/euler/q$1/Main.java
#echo "class Main {" >> q$1/src/org/cmyers/euler/q$1/Main.java
#echo "    public static final void main(String[] args) {" >> q$1/src/org/cmyers/euler/q$1/Main.java
#echo "        System.out.println(\"Problem $1\");" >> q$1/src/org/cmyers/euler/q$1/Main.java
#echo "    }" >> q$1/src/org/cmyers/euler/q$1/Main.java
#echo "}" >> q$1/src/org/cmyers/euler/q$1/Main.java
#echo "" >> q$1/src/org/cmyers/euler/q$1/Main.java
#
