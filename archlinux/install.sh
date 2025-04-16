#!/bin/bash

TEMP_DIR=/mnt/c/tmp

# Use first argument for WSL_NAME if provided
WSL_NAME="${1:-Arch}"

# Make tmp directory if it doesn't exist
if [ ! -d ${TEMP_DIR} ]; then
  echo "${TEMP_DIR} does not exist. Creating..."
  mkdir -p ${TEMP_DIR};
fi

# Replace template name
sed "s/tmplWSL_NAME/$WSL_NAME/g" wsl-configuration/wsl-distribution.conf.tmpl > wsl-configuration/wsl-distribution.conf

# Build image using Dockerfile(that contains necessary wsl files)
docker build -t linux_wsl .

# Run a container we can export
docker run -t --name wsl_export linux_wsl ls

# Export container to tarball
docker export wsl_export > /mnt/c/tmp/linux.tar

# Make it a wsl for double-click installability
cp /mnt/c/tmp/linux.tar /mnt/c/tmp/$WSL_NAME.wsl

# Let's clean up after ourselves now
docker rm wsl_export
docker rmi linux_wsl
rm /mnt/c/tmp/linux.tar
rm wsl-configuration/wsl-distribution.conf
