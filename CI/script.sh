#!/usr/bin/env bash

cd ./build

if [ "${TRAVIS_OS_NAME}" = "windows" ]; then
    cmake --build . --config Release
else
    cmake --build . -- -j3
fi
