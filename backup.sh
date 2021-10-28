#!/bin/bash

BACKUPS_TO_KEEP=100
BACKUP_TYPE=$1

if [ -z "${BACKUP_TYPE}" ]
then
  echo "No BACKUP_TYPE specified. Choices are hourly, daily, or monthly."
  exit 1
fi

if [ "hourly" = "${BACKUP_TYPE}" ]
then
  BACKUPS_TO_KEEP=23
elif [ "daily" = "${BACKUP_TYPE}" ]
then
  BACKUPS_TO_KEEP=6
elif [ "monthly" = "${BACKUP_TYPE}" ]
then
  BACKUPS_TO_KEEP=6
else
  echo "Invalid BACKUP_TYPE given: ${BACKUP_TYPE}. Choices are hourly, daily, or monthly."
  exit 2
fi

MCRCON=/opt/mcrcon/mcrcon
MCDIR=/opt/vanilla_minecraft
BACKUP_DIR="/minecraft_backups/${BACKUP_TYPE}"

RCONHOST=localhost
RCONPORT=25575
RCONPASS=mypassword

# Make sure the backup directory exists
mkdir -p "${BACKUP_DIR}"

# Delete old backups, keeping BACKUPS_TO_KEEP
pushd "${BACKUP_DIR}"
ls -1tr | head -n -"${BACKUPS_TO_KEEP}" | xargs -d '\n' rm -f --
popd

START=`date +%s`
$MCRCON -H $RCONHOST -P $RCONPORT -p $RCONPASS "say Starting ${BACKUP_TYPE} backup"
$MCRCON -H $RCONHOST -P $RCONPORT -p $RCONPASS "save-off"
$MCRCON -H $RCONHOST -P $RCONPORT -p $RCONPASS "save-all"

/bin/tar -cpzf $BACKUP_DIR/minecraft-${BACKUP_TYPE}-backup-$(date +"%Y-%m-%d-%H-%M").tar.gz $MCDIR

$MCRCON -H $RCONHOST -P $RCONPORT -p $RCONPASS "save-on"

END=`date +%s.%N`
DURATION=`/usr/bin/printf "%.2f" $( /bin/echo "${END} - ${START}" | /usr/bin/bc -l )`
$MCRCON -H $RCONHOST -P $RCONPORT -p $RCONPASS "say Backup completed in ${DURATION} seconds"
