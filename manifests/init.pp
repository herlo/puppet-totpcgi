# == Class: totpcgi
#
# Manages totp-cgi server and client.
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
  $install_totpcgi                  = $totpcgi::params::install_totpcgi,
  $install_qrcode                   = $totpcgi::params::install_pincode,
  $provisioning                     = $totpcgi::params::provisioning,
  $totpcgi_config                   = $totpcgi::params::totpcgi_config,
  $totpcgi_owner                    = $totpcgi::params::totpcgi_owner,
  $totpcgi_group                    = $totpcgi::params::totpcgi_group,
  $provisioning_config              = $totpcgi::params::provisioning_config,
  $provisioning_owner               = $totpcgi::params::provisioning_owner,
  $provisioning_group               = $totpcgi::params::provisioning_group,
  $require_pincode                  = $totpcgi::params::require_pincode,
  $success_string                   = $totpcgi::params::success_string,
  $encrypt_secret                   = $totpcgi::params::encrypt_secret,
  $users                            = $totpcgi::params::users,
  $window_size                      = $totpcgi::params::window_size,
  $rate_limit                       = $totpcgi::params::rate_limit,
  $disallow_reuse                   = $totpcgi::params::disallow_reuse,
  $totp_auth                        = $totpcgi::params::totp_auth,
  $hotp_counter                     = $totpcgi::params::hotp_counter,
  $scratch_tokens_n                 = $totpcgi::params::scratch_tokens_n,
  $bits                             = $totpcgi::params::bits,
  $totp_user_mask                   = $totpcgi::params::totp_user_mask,
  $action_url                       = $totpcgi::params::action_url,
  $css_root                         = $totpcgi::params::css_root,
  $templates_dir                    = $totpcgi::params::templates_dir,
  $trust_http_auth                  = $totpcgi::params::trust_http_auth,
  $secret_engine                    = $totpcgi::params::secret_engine,
  $secrets_dir                      = $totpcgi::params::secrets_dir,
  $secret_pg_connect_string         = $totpcgi::params::secret_pg_connect_string,
  $secret_mysql_connect_host        = $totpcgi::params::secret_mysql_connect_host,
  $secret_mysql_connect_user        = $totpcgi::params::secret_mysql_connect_user,
  $secret_mysql_connect_password    = $totpcgi::params::secret_mysql_connect_password,
  $secret_mysql_connect_db          = $totpcgi::params::secret_mysql_connect_db,
  $secret_ldap_url                  = $totpcgi::params::secret_ldap_url,
  $secret_ldap_dn                   = $totpcgi::params::secret_ldap_dn,
  $secret_ldap_cacert               = $totpcgi::params::secret_ldap_cacert,
  $pincode_engine                   = $totpcgi::params::pincode_engine,
  $pincode_usehash                  = $totpcgi::params::pincode_usehash,
  $pincode_makedb                   = $totpcgi::params::pincode_makedb,
  $pincode_file                     = $totpcgi::params::pincode_file,
  $pincode_pg_connect_string        = $totpcgi::params::pincode_pg_connect_string,
  $pincode_mysql_connect_host       = $totpcgi::params::pincode_mysql_connect_host,
  $pincode_mysql_connect_user       = $totpcgi::params::pincode_mysql_connect_user,
  $pincode_mysql_connect_password   = $totpcgi::params::pincode_mysql_connect_password,
  $pincode_mysql_connect_db         = $totpcgi::params::pincode_mysql_connect_db,
  $pincode_ldap_url                 = $totpcgi::params::pincode_ldap_url,
  $pincode_ldap_dn                  = $totpcgi::params::pincode_ldap_dn,
  $pincode_ldap_cacert              = $totpcgi::params::pincode_ldap_cacert,
  $state_engine                     = $totpcgi::params::state_engine,
  $state_dir                        = $totpcgi::params::state_dir,
  $state_pg_connect_string          = $totpcgi::params::state_pg_connect_string,
  $state_mysql_connect_host         = $totpcgi::params::state_mysql_connect_host,
  $state_mysql_connect_user         = $totpcgi::params::state_mysql_connect_user,
  $state_mysql_connect_password     = $totpcgi::params::state_mysql_connect_password,
  $state_mysql_connect_db           = $totpcgi::params::state_mysql_connect_db,
  $state_ldap_url                   = $totpcgi::params::state_ldap_url,
  $state_ldap_dn                    = $totpcgi::params::state_ldap_dn,
  $state_ldap_cacert                = $totpcgi::params::state_ldap_cacert,
  $vhost_name                       = $totpcgi::params::vhost_name,
  $port                             = $totpcgi::params::port,
  $servername                       = $totpcgi::params::servername,
  $serveradmin                      = $totpcgi::params::serveradmin,
  $docroot                          = $totpcgi::params::docroot,
  $suexec_user_group                = $totpcgi::params::suexec_user_group,
  $ssl                              = $totpcgi::params::ssl,
  $ssl_certs_dir                    = $totpcgi::params::ssl_certs_dir,
  $ssl_cacert                       = $totpcgi::params::ssl_cacert,
  $ssl_cert                         = $totpcgi::params::ssl_cert,
  $ssl_key                          = $totpcgi::params::ssl_key,
  $ssl_verify_depth                 = $totpcgi::params::ssl_verify_depth,
  $ssl_verify_client                = $totpcgi::params::ssl_verify_client,
  $error_log_file                   = $totpcgi::params::error_log_file,
  $access_log_file                  = $totpcgi::params::access_log_file,
  $directories                      = $totpcgi::params::directories,
  $broken_selinux_python_policy     = $totpcgi::broken_selinux_python_policy,
) inherits totpcgi::params {
  # Make sure that all the params are properly formatted

  anchor { 'totpcgi::begin': }
  anchor { 'totpcgi::end': }

  include totpcgi::install
  include totpcgi::config
  include totpcgi::service

  Anchor['totpcgi::begin'] ->
    Class['totpcgi::install'] ->
    Class['totpcgi::config'] ->
    Class['totpcgi::service'] ->
  Anchor['totpcgi::end']
}
