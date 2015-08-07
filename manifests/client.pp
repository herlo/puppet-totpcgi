# == Class: totpcgi::client
#
# Client configuration (pam_url, pincodes, and ssl configs).
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

class totpcgi::client (
  $host             = $totpcgi::params::host,
  $host_ip          = $totpcgi::params::host_ip,
  $pam_url_config   = $totpcgi::params::pam_url_config,
  $port             = $totpcgi::params::port,
  $return_code      = $totpcgi::params::success_string,
  $pam_url_prompt   = $totpcgi::params::pam_url_prompt,
  $ssl_cacert       = $totpcgi::params::ssl_cacert,
  $ssl_cert         = $totpcgi::params::ssl_cert,
  $ssl_key          = $totpcgi::params::ssl_key,
) inherits totpcgi::params {

  include pam
  include totpcgi::repo

  package { 'pam_url':
    require => Class['::totpcgi::repo'],
  }

  host { $host:
    ip => $host_ip,
  }

  file { $pam_url_config:
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0640',
    content => template('totpcgi/pam_url.conf.erb'),
    require => [
      Class['pam'],
      Package['pam_url'],
    ],
  }


}
