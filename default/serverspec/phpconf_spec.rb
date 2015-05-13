# encoding: utf-8
# Copyright 2015, Dominik Richter
# License: Apache v2

require 'spec_helper'

describe 'PHP config parameters' do
  # Some things we don't do:
  # * safe_mode
  #   reason: deprecated
  #   see: http://php.net/manual/de/features.safe-mode.php

  # Base configuration

  context php_config('open_basedir') do
    its(:value) { should eq '/srv/http/:/home/:/tmp/:/usr/share/pear/:/usr/share/webapps/' }
  end

  # Time / Memory Quota

  context php_config('max_execution_time') do
    its(:value) { should eq 30 }
  end

  context php_config('max_input_nesting_level') do
    its(:value) { should eq 64 }
  end

  context php_config('memory_limit') do
    its(:value) { should eq '128M' }
  end

  context php_config('post_max_size') do
    its(:value) { should eq '8M' }
  end

  # PHP Capabilities

  # TODO: do we have a recommended minimum-set?
  context php_config('disable_functions') do
    its(:value) { should eq 'php_uname, getmyuid, getmypid, passthru, leak, listen, diskfreespace, tmpfile, link, ignore_user_abord, shell_exec, dl, set_time_limit, exec, system, highlight_file, source, show_source, fpaththru, virtual, posix_ctermid, posix_getcwd, posix_getegid, posix_geteuid, posix_getgid, posix_getgrgid, posix_getgrnam, posix_getgroups, posix_getlogin, posix_getpgid, posix_getpgrp, posix_getpid, posix, _getppid, posix_getpwnam, posix_getpwuid, posix_getrlimit, posix_getsid, posix_getuid, posix_isatty, posix_kill, posix_mkfifo, posix_setegid, posix_seteuid, posix_setgid, posix_setpgid, posix_setsid, posix_setuid, posix_times, posix_ttyname, posix_uname, proc_open, proc_close, proc_get_status, proc_nice, proc_terminate, phpinfo' }
  end

  # TODO: do we have a recommended minimum-set?
  context php_config('disable_classes') do
    its(:value) { should eq '...' }
  end

  context php_config('register_globals') do
    its(:value) { should eq 'Off' }
  end

  context php_config('expose_php') do
    its(:value) { should eq 'Off' }
  end

  context php_config('enable_dl') do
    its(:value) { should eq 'Off' }
  end

  context php_config('default_charset') do
    its(:value) { should eq 'utf-8' }
  end

  context php_config('default_mimetype') do
    its(:value) { should eq 'text/html' }
  end

  # removed as of PHP5.4, so...
  # remove these test?
  context php_config('magic_quotes_gpc') do
    its(:value) { should eq nil}
  end
  context php_config('magic_quotes_sybase') do
    its(:value) { should eq nil}
  end

  # # removed // how to test this?
  # context php_config('magic_quotes_runtime') do
  #   its(:value) { should eq 'Off'}
  # end

  # Upload / Open

  context php_config('allow_url_fopen') do
    its(:value) { should eq 'Off' }
  end

  context php_config('allow_url_include') do
    its(:value) { should eq 'Off' }
  end

  context php_config('file_uploads') do
    its(:value) { should eq 'Off' }
  end

  # Alternative: restrict upload maximum to prevent
  # system overload:
  # upload_tmp_dir = /var/php_tmp
  # upload_max_filezize = 10M

  # Log // Information Disclosure

  context php_config('display_errors') do
    its(:value) { should eq 'Off' }
  end

  context php_config('display_startup_errors') do
    its(:value) { should eq 'Off' }
  end

  context php_config('log_errors') do
    its(:value) { should eq 'On' }
  end

  # Session Handling

  context php_config('session.save_path') do
    its(:value) { should eq '/var/lib/php' }
  end

  context php_config('session.cookie_httponly') do
    its(:value) { should eq 1 }
  end

  # Mail

  context php_config('mail.add_x_header') do
    its(:value) { should eq 'Off' }
  end

end
