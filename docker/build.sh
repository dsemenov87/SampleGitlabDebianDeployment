#!/bin/bash

docker build \
  --build-arg='NUGET_MODUL_SRC=http://172.21.13.126:8085/nuget' \
  -t dotnet-debian-build .

