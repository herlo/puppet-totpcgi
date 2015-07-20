# == Class: totpcgi::service
#
# Ensures a running totpcgi service
#
# === Authors
#
# Clint Savage <herlo@linuxfoundation.org>
#
# === Copyright
#
# Copyright 2015 Clint Savage
#
# === License
#
# @License Apache-2.0 <http://spdx.org/licenses/Apache-2.0>
#
class totpcgi::service (
) inherits totpcgi {

  class { 'apache':
    default_vhost => false,
  }

  ::apache::vhost{ "$vhost_name":
    port              => $port,
    servername        => $servername,
    serveradmin       => $serveradmin,
    docroot           => $docroot,
    suexec_user_group => $suexec_user_group,
    ssl               => $ssl,
    ssl_ca            => $ssl_cacert,
    ssl_cert          => $ssl_cert,
    ssl_key           => $ssl_key,
    ssl_verify_client => $ssl_verify_client,
    ssl_verify_depth  => $ssl_verify_depth,
    error_log_file    => $error_log_file,
    access_log_file   => $access_log_file,
    directories       => $directories,

#    # Use this for totp.cgi
#    AddHandler cgi-script .cgi
#    DirectoryIndex index.cgi
#
#    # Or use this for totp.fcgi:
#    #AddHandler fcgid-script .fcgi
#    #DirectoryIndex index.fcgi

  }

}
