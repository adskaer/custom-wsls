#!/bin/bash

# Replace name if we have an argument
DEFAULTVALUE=Alpine
NAME="${1:-$DEFAULTVALUE}"
sed "s/$DEFAULTVALUE/$NAME/g" wsl-configuration/wsl-distribution.conf.tmpl > wsl-configuration/wsl-distribution.conf

# Build image using Dockerfile(that contains necessary wsl files)
docker build -t alpine_wsl .

# Run a container we can export
docker run -t --name wsl_export alpine_wsl ls

# Export container to tarball
docker export wsl_export > /mnt/c/tmp/alpine.tar

# Make it a wsl for double-click installability
cp /mnt/c/tmp/alpine.tar /mnt/c/tmp/$NAME.wsl

# Let's clean up after ourselves now
docker rm wsl_export
docker rmi alpine_wsl
rm /mnt/c/tmp/alpine.tar
rm wsl-configuration/wsl-distribution.conf
