#!/bin/bash
# Public MWMBashCommand
#

source ./envs/my-new-system.env
source ./cli/lib/utils.sh

./cli/manage-system/stop.sh

podman pod rm mwm-deployment-pod-0
if [[ $? == 0 ]]
then
    echo "SUCCESS: removed pod mwm"
else
    echo "Pod mwm not found, so not removing. Continuing..."
fi

#FIXME: Why sudo?
sudo rm -rf \
    mediawiki_root \
    snapshots \
    mariadb_data \
    mwmconfigdb.sqlite

./cli/install-system/install-system.sh