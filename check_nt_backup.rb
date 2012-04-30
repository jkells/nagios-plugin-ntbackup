#!/usr/bin/env ruby -Ku
#
# Copyright (C) 2012 Jared Kells < jkells@gmail.com >
#
# License: MIT (See: LICENSE)
#

require 'date'
require_relative './check_nt_backup_config'

def report_critical(message)
  puts "Critical: " + message
  exit(2)
end

def report_ok
  puts "OK: Successful backup performed."
  exit(0)
end

def check_log_file
  unless Dir.exists? BACKUP_DIRECTORY
    report_critical("Unable to find backup log files.")
  end

  Dir.chdir(BACKUP_DIRECTORY) do
    # Find the most recent file in the log directory.
    files = Dir.entries(".")
      .select { |f| File.file?(f) }
      .sort_by { |f| File.mtime(f) }
      .reverse

    if files.count == 0
      report_critical("No backup logs found.")
    end

    latest_log_file = File.new(files.first, "rb:utf-16le:utf-8")

    unless backup_is_recent?(latest_log_file)
      report_critical("Last backup performed more than #{MAX_AGE[Date.today.wday]} hours ago.")
    end

    unless backup_was_success?(latest_log_file)
      report_critical("Log file does not report a successful backup.")
    end

    report_ok()
  end
end


def backup_is_recent?(latest_log_file)
  modified_time = latest_log_file.mtime
  age_seconds = Time.now - modified_time
  age_hours = age_seconds / 60.0 /60.0
  age_hours < MAX_AGE[Date.today.wday]
end

def backup_was_success?(latest_log_file)
  latest_log_file.each {|line|
    return false if line.include?("Error:")
    return false if line.include?("The requested media failed to mount")
  }

  true
end

#Entry point.
check_log_file


