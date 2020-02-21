#!/usr/bin/env bash

cd ./build

# Windows specific options
if [ "${TRAVIS_OS_NAME}" = "windows" ]; then
  choco install hub
elif [ "${TRAVIS_OS_NAME}" = "linux" ]; then
  sudo snap install hub --classic
else
  brew install hub
fi

chmod +x ../CI/deploy.sh
