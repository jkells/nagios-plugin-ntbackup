NTBackup Nagios Plugin
======================

Overview
--------

Simple plugin for Nagios to test if nightly backups completed successfully.

Prerequisites
-------------
 * Install NSClient++: http://www.nsclient.org/nscp
 * Install ruby: http://rubyinstaller.org/
 * Place the .rb scripts in the NSClient++ scripts folder, i.e: C:\Program Files\NSClient++\scripts
 * Configure the script as an external script for NSClient++. See the sample below if you need help.
 * General information about monitoring Windows machines with Nagios can be found here: http://www.nsclient.org/nscp

Configuration
-------------
* Update the BACKUP_DIRECTORY constant in check_nt_backup.rb to point to the NTBackup log directory. This directory
is in the user profile of the user account that runs NTBackup.
* If you don't run backups every night you may need to adjust the MAX_AGE constant in the script.
* The MAX_AGE array specifies a different number of hours for each day. This is in case you don't run
  backups on weekends.

Example NSC.ini
-------------------
In a default installation it will be here: C:\Program Files\NSClient++\

The following is a minimalist NSC.ini file. This will get you up and running but you should
probably configure NSC++ with a proper allowed_hosts directive and a password.

    [modules]
    NRPEListener.dll
    CheckExternalScripts.dll

    [Settings]
    use_file=1
    allowed_hosts=

    [External Scripts]
    check_nt_backup=ruby.exe scripts\check_backup.rb