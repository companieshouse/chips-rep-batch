#!/bin/bash

# sed command to add export to beginning of each line and quote values
env | sed 's/^/export /;s/=/&"/;s/$/"/' > /apps/rep/env.variables

# set rep user crontab
su -c 'crontab /apps/rep/cron/crontab.txt' rep

# Start cron
crond -n