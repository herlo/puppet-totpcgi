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
) inherits totpcgi::params {

  include totpcgi::repo

  package { 'pam_url':
    require => Class['::totpcgi::repo'],
  }

  host { "$host":
    ip => $host_ip,
  }

}
