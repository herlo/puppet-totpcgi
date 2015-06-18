# == Class: totpcgi::install
#
# Installs totpcgi into the indicated virtualenv
#
# == Parameters
#
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

class totpcgi::install (
  $install_totpcgi = $totpcgi::params::install_totpcgi,
) inherits totpcgi::params {
  validate_bool($install_totpcgi)

  if ($install_totpcgi) {

    include totpcgi::repo

    package { ['totpcgi', 'totpcgi-selinux', 'totpcgi-provisioning']:
      require => Class['::totpcgi::repo']
    }

  }

}
