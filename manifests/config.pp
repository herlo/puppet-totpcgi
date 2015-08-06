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
  $secrets_dir,
  $secret_engine,
  $pincode_engine,
  $pincode_file,
  $pincode_ldap_cacert,
  $state_engine,
  $state_dir,
  $broken_selinux_python_policy,
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

  if $broken_selinux_python_policy {
      include selinux::base
      selinux::module { 'mytotpcgi':
        source => 'puppet:///modules/totpcgi/mytotpcgi.te'
      }
  }

}

