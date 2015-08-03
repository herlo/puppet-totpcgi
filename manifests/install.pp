# == Class: totpcgi::install
#
# Installs totpcgi into the indicated virtualenv
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
) inherits totpcgi {

  if ($install_totpcgi) {

    include totpcgi::repo

    package { ['totpcgi', 'totpcgi-selinux', 'totpcgi-provisioning']:
      require => Class['::totpcgi::repo']
    }
  }

  # since python-qrcode isn't technically required, let's make it optional
  # the default will be to install the package, however
  if ($install_qrcode) {

    package { 'python-qrcode':
    }
  }


}
