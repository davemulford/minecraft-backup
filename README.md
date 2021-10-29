## Overview

This script allows for hourly, daily, and monthly backups of a Minecraft world.

Choose one of the options below for running the backups every hour, day, and month.

## Cron setup

    # Backup at the top of every hour
    0 * * * * backup.sh hourly

    # Backup at 23:50 every day
    50 23 * * * backup.sh daily

    # Backup at 00:15 on the 15th of every month
    15 0 15 * * backup.sh monthly

## Systemd Setup

See the `*.timer` and `*.service` files in the `systemd-timers` directory and modify them as necessary. Once ready, use the following commands to start and enable the timers.

    # systemctl daemon-reload
    
    # systemctl enable --now minecraft-hourly-backup.timer
    # systemctl enable --now minecraft-daily-backup.timer
    # systemctl enable --now minecraft-monthly-backup.timer
