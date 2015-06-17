# == Class: totpcgi
#
# Manages totp-cgi server and client.
#
# === Parameters
#
# [*configuration*]
#   Hash that defines the configuration for totpcgi.
#   This will get written to /etc/totpcgi/totpcgi.yaml so the hash
#   will be converted to YAML
#
#   *Type*: hash
#
#   *default*: none - this is a required parameter
#
# === Variables
#
# [*group*]
#   The group that totpcgi should operate as
#
#   *Type*: string
#
#   *default*: totpcgi
#
# [*user*]
#   The user that totpcgi should operate as
#
#   *Type*: string
#
#   *default*: totpcgi
#
# [*user_home*]
#   The home directory for the totpcgi user
#
#   *Type*: string (absolute path)
#
#   *default*: /home/totpcgi
#
# [*venv_path*]
#   Fully qualified path to the virtualenv that totpcgi should be
#   installed into. The virtualenv is not managed by this module. It is
#   recommend that a module such as stankevich/python be used to manage
#   in a virtualenv
#
#   *Type*: string (absolute path)
#
#   *default*: /opt/venv-totpcgi
#
# [*vcs_path*]
#   Fully qualified path to the vcs repo that totpcgi will be checked
#   out into. totpcgi will utilize the virtualenv to execute a pip
#   install out of this vcsrepo
#
#   *Type*: string (absolute path)
#
#   *default*: /opt/vcs-totpcgi
#
# [*vcs_source*]
#   vcsrepo source path for totpcgi.
#
#   *Type*: string (vcsrepo URL)
#
#   *default*: GitHub totpcgi repo from OpenStack
#
# [*vcs_type*]
#   vcsrepo requires a type to be passed to it
#
#   *Type*: string
#
#   *default*: git
#
# [*vcs_revision*]
#   Revision to pass to the vcsrepo configuration
#
#   *Type*: string
#
#   *default*: undef (aka use latest HEAD)
#
# === Examples
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
class totpcgi (
  $configuration,
  $configuration_file = $totpcgi::params::configuration_file,
  $group              = $totpcgi::params::group,
  $user               = $totpcgi::params::user,
  $user_home          = $totpcgi::params::user_home,
  $venv_path          = $totpcgi::params::venv_path,
  $vcs_path           = $totpcgi::params::vcs_path,
  $vcs_source         = $totpcgi::params::vcs_source,
  $vcs_type           = $totpcgi::params::vcs_type,
  $vcs_revision       = undef
) inherits totpcgi::params {
  # Make sure that all the params are properly formatted
  validate_hash($configuration)
  validate_absolute_path($configuration_file)
  validate_string($group)
  validate_string($user)
  validate_absolute_path($user_home)
  validate_absolute_path($venv_path)
  validate_absolute_path($vcs_path)
  validate_string($vcs_source)
  validate_string($vcs_type)

  if ($vcs_revision != undef) {
    validate_string($vcs_revision)
  }

  anchor { 'totpcgi::begin': }
  anchor { 'totpcgi::end': }

  class { 'totpcgi::install':
    group        => $group,
    user         => $user,
    user_home    => $user_home,
    venv_path    => $venv_path,
    vcs_path     => $vcs_path,
    vcs_source   => $vcs_source,
    vcs_type     => $vcs_type,
    vcs_revision => $vcs_revision,
  }

  class { 'totpcgi::config':
    configuration      => $configuration,
    configuration_file => $configuration_file,
    group              => $group,
    user               => $user,
  }

  include totpcgi::service

  Anchor['totpcgi::begin'] ->
    Class['totpcgi::install'] ->
    Class['totpcgi::config'] ->
    Class['totpcgi::service'] ->
  Anchor['totpcgi::end']
}
