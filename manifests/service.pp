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

}
