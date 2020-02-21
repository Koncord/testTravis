#!/usr/bin/env bash

cd ./build

CPACK=cpack

ARCH_FILE='testTravisCI-1.2.3-'

# Windows specific options
if [ "${TRAVIS_OS_NAME}" = "windows" ]; then
  ARCH_FILE+='win'
  if [ "${BUILD_ARCH}" = "x64" ]; then
    ARCH_FILE+='64'
  else
    ARCH_FILE+='32'
  fi
  CPACK='/c/Program Files/CMake/bin/cpack.exe' # chocolatey sets wrong cpack in PATH
elif [ "${TRAVIS_OS_NAME}" = "linux" ]; then
  ARCH_FILE+='Linux'
else
  ARCH_FILE+='Darwin'
fi

ARCH_FILE+='.7z'

"$CPACK" -G 7Z .
CHECK_RELEASES=$(hub release --include-drafts $TRAVIS_TAG)
if echo "$CHECK_RELEASES" | grep -q "$TRAVIS_TAG"; then
  hub release edit -da "./$ARCH_FILE" -m "" $TRAVIS_TAG
else
  hub release create -da "./$ARCH_FILE" -m "$TRAVIS_TAG" $TRAVIS_TAG
fi
