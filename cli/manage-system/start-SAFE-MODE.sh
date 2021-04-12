#!/bin/bash

# MWM Feature:
#
# The dataspects MediaWiki Docker images in itself provide a working MediaWiki System setup if
# operated by the means of MWM.
#
# This means that here is an EPHEMERAL working MediaWiki System setup if the mediawiki service
# in docker-compose.yml is deprived of all ./mediawiki_root/w/* volumes.

# REFACTOR!

source ./cli/lib/utils.sh

source ./envs/my-new-system.env

podman container stop mwm-deployment-pod-0-mediawiki
podman container start mwm-deployment-pod-0-mediawiki-safemode

APACHE_CONTAINER_NAME=mwm-deployment-pod-0-mediawiki-safemode
source ./cli/lib/waitForMariaDB.sh

podman exec $APACHE_CONTAINER_NAME /bin/bash -c \
  "source ./cli/lib/utils.sh && removeFromLocalSettings \"/\$wgReadOnly = true;/d\""  

runMWUpdatePHP

podman exec $APACHE_CONTAINER_NAME /bin/bash -c \
  "source ./cli/lib/utils.sh && addToLocalSettings '\$wgReadOnly = true;'"