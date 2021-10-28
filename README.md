## Overview

This script allows for hourly, daily, and monthly backups of a Minecraft world.

## Cron setup

    # Backup at the top of every hour
    0 * * * * backup.sh hourly

    # Backup at 23:50 every day
    50 23 * * * backup.sh daily

    # Backup at 00:15 on the 15th of every month
    15 0 15 * * backup.sh monthly
