#!/usr/bin/env ruby -Ku
#
# Copyright (C) 2012 Jared Kells < jkells@gmail.com >
#
# License: MIT (See: LICENSE)
#
# Configuration File.

#Location of NTBackup Files.
BACKUP_DIRECTORY = "C:/Documents and Settings/Administrator/Local Settings/Application Data/Microsoft/Windows NT/NTBackup/data"

# Critical error if the backups hasn't run in MAX_AGE hours.
# Define MAX_AGE for each day of the week.
MAX_AGE = [
  24 + 24,      # Sunday
  24 + 24 + 24, # Monday
  24,           # Tuesday
  24,           # Wednesday
  24,           # Thursday
  24,           # Friday
  24,           # Saturday
]