# == Class: totpcgi::repo
#
# Enables totpcgi COPR repo
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

class totpcgi::repo {

  yumrepo { 'copr-herlo-totpcgi':
    ensure   => present,
    name     => 'copr-herlo-totpcgi',
    descr    => 'COPR totp-cgi repo',
    baseurl  => 'https://copr-be.cloud.fedoraproject.org/results/herlo/totpcgi/epel-7-$basearch/',
    gpgcheck => 'no',
    enabled  => true,
  }
}
