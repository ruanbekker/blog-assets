#!/usr/bin/env bash

for file in $(find manifests/ -name "*.y*ml")
do
  sed -i "s/\$CHANGEME_DRONERPCSECRET/$CHANGEME_DRONERPCSECRET/g" ${file}
  sed -i "s/\$CHANGEME_INGRESSENDPOINT/$CHANGEME_INGRESSENDPOINT/g" ${file}
  sed -i "s/\$CHANGEME_GITEASECRETID/$CHANGEME_GITEASECRETID/g" ${file}
done
