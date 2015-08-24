# == Class: totpcgi::config
#
# Configures totpcgi files
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

class totpcgi::config (
  $totpcgi_config,
  $totpcgi_config_dir,
  $totpcgi_group,
  $totpcgi_owner,
  $provisioning_config,
  $provisioning_group,
  $provisioning_owner,
  $window_size,
  $require_pincode,
  $success_string,
  $encrypt_secret,
  $window_size,
  $rate_limit,
  $scratch_tokens_n,
  $bits,
  $totp_user_mask,
  $action_url,
  $css_root,
  $templates_dir,
  $trust_http_auth,
  $secret_engine,
  $secrets_dir                = undef,
  $secret_pg_connect_string   = undef,
  $secret_mysql_connect_host  = undef,
  $secret_mysql_connect_user  = undef,
  $secret_mysql_connect_password = undef,
  $secret_mysql_connect_db    = undef,
  $pincode_engine,
  $pincode_usehash,
  $pincode_makedb,
  $pincode_file               = undef,
  $pincode_pg_connect_string  = undef,
  $pincode_mysql_connect_host = undef,
  $pincode_mysql_connect_user = undef,
  $pincode_mysql_connect_password = undef,
  $pincode_mysql_connect_db   = undef,
  $pincode_ldap_url           = undef,
  $pincode_ldap_dn            = undef,
  $pincode_ldap_cacert        = undef,
  $state_engine,
  $state_dir                = undef,
  $state_pg_connect_string  = undef,
  $state_mysql_connect_host = undef,
  $state_mysql_connect_user = undef,
  $state_mysql_connect_password = undef,
  $state_mysql_connect_db   = undef,
  $broken_selinux_python_policy = false,
) {

  file { $totpcgi_config_dir:
    ensure => directory,
    owner  => $provisioning_owner,
    group  => $totpcgi_group,
    mode   => '0750',
  }

  file { $totpcgi_config:
    ensure  => file,
    owner   => $totpcgi_owner,
    group   => $totpcgi_group,
    mode    => '0640',
    content => template('totpcgi/totpcgi.conf.erb'),
  }

  file { $provisioning_config:
    ensure  => file,
    owner   => $provisioning_owner,
    group   => $provisioning_group,
    mode    => '0640',
    content => template('totpcgi/provisioning.conf.erb'),
  }

  if $secret_engine == 'file' {
    file { $secrets_dir:
      ensure => directory,
      owner  => $provisioning_owner,
      group  => $totpcgi_group,
      mode   => '0750',
    }
  }

  if $pincode_engine == 'file' {
    file { $pincode_file:
      ensure => file,
      owner  => 'root',
      group  => $totpcgi_group,
      mode   => '0640',
    }
  }

  if $pincode_engine == 'ldap' {
    file { $pincode_ldap_cacert:
      ensure  => file,
    }
  }

  if $state_engine == 'file' {
    file { $state_dir:
      ensure => directory,
      owner  => $provisioning_owner,
      group  => $totpcgi_group,
      mode   => '0770',
    }
  }

  # enable httpd_unified SELinux boolean
  selboolean {'httpd_unified':
    persistent => true,
    value      => on,
  }

  if $broken_selinux_python_policy {
    include selinux::base
    selinux::module { 'mytotpcgi':
      source => 'puppet:///modules/totpcgi/mytotpcgi.te'
    }
  }

}

