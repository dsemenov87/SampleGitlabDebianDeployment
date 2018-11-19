#!/bin/bash
set -e

export TAG=$(echo $BRANCH | tr "/" "_")
export PKG_NAME="${SERVICE}:${TAG}"
export NUGET_OFFICIAL_SRC="https://api.nuget.org/v3/index.json"
export RUNTIME=debian-x64
export CONFIG=Release

echo '1. Starting unit-tests...'

modul_unit_tests.sh

echo '2. Creating debian package...'

modul_build.sh