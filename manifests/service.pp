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
    ssl_certs_dir     => $ssl_certs_dir,
    ssl_ca            => $ssl_cacert,
    ssl_cert          => $ssl_cert,
    ssl_key           => $ssl_key,
    ssl_verify_client => $ssl_verify_client,
    ssl_verify_depth  => $ssl_verify_depth,
    error_log_file    => $error_log_file,
    access_log_file   => $access_log_file,
    directories       => $directories,
    require           => [
      File["$docroot"],
      File["${docroot}/index.cgi"],
    ],
  }

  file { "$docroot":
    ensure  => directory,
    owner   => $totpcgi_owner,
    group   => $totpcgi_group,
    mode    => '0751',
  }

  file { "${docroot}/index.cgi":
    ensure  => file,
    owner   => $totpcgi_owner,
    group   => $totpcgi_group,
    mode    => '0550',
  }


}
