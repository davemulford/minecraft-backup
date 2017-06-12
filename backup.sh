#!/bin/bash

MCRCON=/opt/minecraft-backup/mcrcon
MCDIR=/home/david/minecraft-derpcraft

RCONHOST=localhost
RCONPORT=1234
RCONPASS=mypassword

# Delete any backups older than 6 hours
/usr/bin/find /opt/minecraft-backup/ -type f -mmin +360 -iname 'minecraft-derpcraft-backup*' -delete

START=`date +%s`
$MCRCON -H $RCONHOST -P $RCONPORT -p $RCONPASS "say Starting backup"
$MCRCON -H $RCONHOST -P $RCONPORT -p $RCONPASS "save-off"
$MCRCON -H $RCONHOST -P $RCONPORT -p $RCONPASS "save-all"

/bin/tar -cpzf /opt/minecraft-backup/minecraft-derpcraft-backup-$(date +"%Y-%m-%d-%H-%M").tar.gz $MCDIR

$MCRCON -H $RCONHOST -P $RCONPORT -p $RCONPASS "save-on"

END=`date +%s.%N`
DURATION=`/usr/bin/printf "%.2f" $( /bin/echo "${END} - ${START}" | /usr/bin/bc -l )`
$MCRCON -H $RCONHOST -P $RCONPORT -p $RCONPASS "say Backup completed in ${DURATION} seconds"
