#!/bin/bash

set -e

for i in /src/test/*.UnitTests/*.*sproj; do 
  if [ -f "$i" ]; then 
    modul_restore.sh $i
    dotnet test $i --no-restore
  fi 
done;
