# mediawiki-manager

The following procedures are currently tested on Ubuntu 20.04 including docker-compose.
## Install

1. `user@server:~$ git clone https://github.com/dataspects/mediawiki-manager.git`
2. `user@server:~$ cd mediawiki-manager`
3. `user@server:~/mediawiki-manager$`
4. Download MediaWiki Canasta archives into `~/mediawiki-manager`:
    * `user@server:~/mediawiki-manager$ wget -c https://www.dropbox.com/s/p5r2qsar1q0u4i3/mediawiki-root-w-folder-1.35.0-3.2.1.tar.gz`
    * `user@server:~/mediawiki-manager$ wget -c https://www.dropbox.com/s/zncf0q288um5gic/mediawiki-root-w-folder-1.35.1-3.2.2.tar.gz`
    * ...
5. Configure `~/mediawiki-manager/CanastaInstanceSettings.env`
    * CANASTA_INSTANCE_ROOT to the mediawiki-manager directory (e.g. `/home/ubuntu/mediawiki-manager`)
    * CANASTA_INSTANCE_ROOT_OWNER to the correct user (e.g. `ubuntu`)
    * MARIADB_ROOT_PASSWORD a new root password if required
    * WG_DB_PASSWORD to a new db password if required
6. `user@server:~/mediawiki-manager$ ./install-canasta-version.sh`

## View
1. The wiki is now accessible on localhost
2. Install lynx to view the wiki from the command line

## Operate

*Note: MediaWiki Canasta runs on an Apache/PHP setup based on this [Dockerfile](https://github.com/dataspects/dataspectsSystemBuilder/blob/master/docker-images/php-apache/Dockerfile).*

**START the MediaWiki Canasta instance**

`user@server:~/mediawiki-manager$ sudo docker-compose --env-file ./CanastaInstanceSettings.env up -d`

**STOP the MediaWiki Canasta instance**

`user@server:~/mediawiki-manager$ sudo docker-compose --env-file ./CanastaInstanceSettings.env down`

## Switch (Upgrade)

1. Edit `~/mediawiki-manager/switch-canasta-version.sh`:
    * NEW_CANASTA_ARCHIVE=`mediawiki-root-w-folder-1.35.1-3.2.2.tar.gz`
2. `user@server:~/mediawiki-manager$ ./switch-canasta-version.sh`

## Snapshooting (Backup/Restore)

MediaWiki Canasta uses https://restic.net.

The installer creates a restic repository at `~/mediawiki-manager/$RESTIC_REPOSITORY` protected by `$RESTIC_PASSWORD`.

**TAKE snapshot**

Currently this snapshoots `$MEDIAWIKI_ROOT_FOLDER` into `~/mediawiki-manager/$RESTIC_REPOSITORY`.

`user@server:~/mediawiki-manager$ ./take-restic-snapshot.sh`

**VIEW snapshots**

`user@server:~/mediawiki-manager$ ./view-restic-snapshots.sh`

**RESTORE snapshot**

`user@server:~/mediawiki-manager$ ./restore-restic-snapshot.sh`

Currently this restores the latest snapshot into `~/mediawiki-manager/$RESTIC_RESTORE_FOLDER`.
