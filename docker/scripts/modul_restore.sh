#!/bin/bash

dotnet restore $1 -r ${RUNTIME} -s ${NUGET_OFFICIAL_SRC} -s ${NUGET_MODUL_SRC}
