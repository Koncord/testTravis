#!/usr/bin/env bash

cd ./build

# Windows specific options
if [ "${TRAVIS_OS_NAME}" = "windows" ]; then
  ARCH_FILE+='win'
  choco install hub
elif [ "${TRAVIS_OS_NAME}" = "linux" ]; then
  ARCH_FILE+='linux'
  sudo snap install hub --classic
else
  ARCH_FILE+='macos'
  brew install hub
fi

if [ $"BUILD_ARCH" = "x64" ]; then
  ARCH_FILE+='64'
else
  ARCH_FILE+='32'
fi

chmod +x ../CI/deploy.sh
