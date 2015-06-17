# == Class: totpcgi::config
#
# Configures totpcgi
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
class totpcgi::config (
  $configuration,
  $configuration_file,
  $group,
  $user
) {
  # Make sure the params are properly formatted
  validate_hash($configuration)
  validate_absolute_path($configuration_file)
  validate_string($group)
  validate_string($user)

  file { $configuration_file:
    ensure  => file,
    owner   => $user,
    group   => $group,
    mode    => '0644',
    content => inline_template('<%= @configuration.to_yaml %>'),
  }
}
