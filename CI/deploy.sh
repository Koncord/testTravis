#!/usr/bin/env bash

cd ./build

CPACK=cpack
COMMIT_HASH=$(git rev-parse HEAD)
TAG_NAME=$(git describe --tags)

ARCH_FILE="testTravisCI-${TAG_NAME}-${COMMIT_HASH}-"

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
  ARCH_FILE+="Linux-$(uname -m)"
else
  ARCH_FILE+='Darwin'
fi

ARCH_FILE+='.7z'

"$CPACK" -G 7Z .
CHECK_RELEASES=$(hub release --include-drafts TAG_NAME)
if echo "$CHECK_RELEASES" | grep -q "${TAG_NAME}"; then
  echo "Adding new file to release. Tag: ${TAG_NAME}"
  hub release edit -m '' -a "./$ARCH_FILE" "${TAG_NAME}"
else
  echo "Creating new release. Tag: ${TAG_NAME}"
  hub release create -m "${TAG_NAME}" -a "./$ARCH_FILE" "${TAG_NAME}"
fi
