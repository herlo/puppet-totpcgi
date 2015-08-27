# == Class: totpcgi::service
#
# Ensures a running totpcgi service
#
# === Authors
#
# Clint Savage <herlo@linuxfoundation.org>
# Andrew Grimberg <agrimberg@linuxfoundation.org>
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
  $vhost_name,
  $port,
  $servername,
  $serveradmin,
  $docroot,
  $suexec_user_group,
  $ssl              = true,
  $ssl_certs_dir    = undef,
  $ssl_cacert,
  $ssl_cert,
  $ssl_key,
  $ssl_verify_client,
  $ssl_verify_depth,
  $totpcgi_owner,
  $totpcgi_group,
  $access_log_file  = undef,
  $error_log_file   = undef,
  $directories      = undef,
  $tokens           = undef,
  $provisioning     = undef,
) {
  validate_string($vhost_name)
  validate_integer($port)
  validate_string($servername)
  validate_string($serveradmin)
  validate_bool($ssl)
  if $ssl_certs_dir {
    validate_string($ssl_certs_dir)
  }
  validate_absolute_path($ssl_cacert)
  validate_absolute_path($ssl_cert)
  validate_absolute_path($ssl_key)
  validate_string($ssl_verify_client)
  validate_integer($ssl_verify_depth)
  validate_string($totpcgi_owner)
  validate_string($totpcgi_group)
  validate_absolute_path($docroot)
  if $access_log_file {
    validate_string($access_log_file)
  }
  if $error_log_file {
    validate_string($error_log_file)
  }
  if $directories {
    validate_hash($directories)
  }

  class { 'apache':
    default_vhost => false,
  }

  ::apache::vhost{ $vhost_name:
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
      File[$docroot],
      File["${docroot}/index.cgi"],
    ],
  }

  file { $docroot:
    ensure => directory,
    owner  => $totpcgi_owner,
    group  => $totpcgi_group,
    mode   => '0751',
  }

  file { "${docroot}/index.cgi":
    ensure  => file,
    seltype => 'totpcgi_script_exec_t',
    owner   => $totpcgi_owner,
    group   => $totpcgi_group,
    mode    => '0550',
  }

  if $provisioning == 'manual' {
    create_resources('totpcgi::provision', $tokens)
  }

}
