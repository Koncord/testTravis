#!/usr/bin/env bash

cd ./build

cpack -G 7Z .

ARCH_FILE='testTravisCI-1.2.3-'

# Windows specific options
if [ "${TRAVIS_OS_NAME}" = "windows" ]; then
  ARCH_FILE+='win'
elif [ "${TRAVIS_OS_NAME}" = "linux" ]; then
  ARCH_FILE+='linux'
else
  ARCH_FILE+='macos'
fi

if [ $"BUILD_ARCH" = "x64" ]; then
  ARCH_FILE+='64'
else
  ARCH_FILE+='32'
fi

ARCH_FILE+='7.z'

hub release create -da "./$ARCH_FILE" -m "$TRAVIS_TAG" $TRAVIS_TAG