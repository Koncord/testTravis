#!/usr/bin/env bash

mkdir build
cd build

cmake ../src \
    -DCMAKE_BUILD_TYPE=Release
