#!/bin/bash

set -e

export DEB_DIR="/src/out/${PKG_NAME}-${VERSION}"

mkdir -p $DEB_DIR/DEBIAN
mkdir -p $DEB_DIR/etc/modulbank/${SERVICE}.conf.d
mkdir -p $DEB_DIR/lib/systemd/system
mkdir -p $DEB_DIR/usr/lib/modulbank/${SERVICE}/service
#mkdir -p $DEB_DIR/usr/lib/modulbank/${SERVICE}/cron

dotnet_publish() {
    modul_restore.sh $1
    dotnet publish $1 \
      --no-restore \
      --self-contained=false \
      -c ${CONFIG} \
      -r ${RUNTIME} \
      -o $2
}

apply_templates() {
    cp /src/etc/.conf $DEB_DIR/etc/modulbank/${SERVICE}.conf

    envsubst < /tmp/debian/etc/modulbank/template.conf > $DEB_DIR/etc/modulbank/${SERVICE}.conf.d/staging.conf
     
    envsubst < /tmp/debian/lib/systemd/system/template.service > $DEB_DIR/lib/systemd/system/${SERVICE}.service

    envsubst < /tmp/debian/DEBIAN/changelog > $DEB_DIR/DEBIAN/changelog
    envsubst < /tmp/debian/DEBIAN/conffile  > $DEB_DIR/DEBIAN/conffile
    envsubst < /tmp/debian/DEBIAN/control   > $DEB_DIR/DEBIAN/control
    envsubst < /tmp/debian/DEBIAN/dirs      > $DEB_DIR/DEBIAN/dirs
    envsubst < /tmp/debian/DEBIAN/preinst   > $DEB_DIR/DEBIAN/preinst
    envsubst < /tmp/debian/DEBIAN/postinst  > $DEB_DIR/DEBIAN/postinst
    envsubst < /tmp/debian/DEBIAN/prerm     > $DEB_DIR/DEBIAN/prerm
    envsubst < /tmp/debian/DEBIAN/postrm    > $DEB_DIR/DEBIAN/postrm

    for i in $DEB_DIR/usr/lib/modulbank/${SERVICE}/*/*.so; do 
        if [ -f "$i" ]; then 
            strip -S -o $i $i
        fi 
    done;
 
    chmod -R 544 $DEB_DIR/usr/lib/modulbank/${SERVICE}
    chmod -R 555 $DEB_DIR/DEBIAN/pre*
    chmod -R 555 $DEB_DIR/DEBIAN/post*
}

for i in /src/service/*.*sproj; do 
  if [ -f "$i" ]; then 
    dotnet_publish $i $DEB_DIR/usr/lib/modulbank/${SERVICE}/service
  fi 
done;

#for i in /src/cron/*/*.*sproj; do 
#  if [ -f "$i" ]; then 
#    dotnet_publish $i $DEB_DIR/usr/lib/${SERVICE}/cron/?
#  fi 
#done;

apply_templates

dpkg-deb --build ${DEB_DIR}

mv "${DEB_DIR}.deb" /var/lib/deb/
