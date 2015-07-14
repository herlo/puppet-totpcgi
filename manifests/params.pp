# == Class: totpcgi::params
#
# Defaults and defines for use with totpcgi
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
class totpcgi::params {
  $install_totpcgi    = true,
  $install_qrcode     = true,
  $require_pincode    = 'False',
  $success_string     = 'OK',
  $encrypt_secret     = 'False',
  $window_size        = '3',
  $rate_limit         = '3, 30',
  $scratch_tokens_n   = '5',
  $bits               = '80',
  $totp_user_mask     = '$username@example.com',
  $action_url         = '/index.cgi',
  $css_root           = '/',
  $templates_dir      = '/etc/totpcgi/templates',
  $trust_http_auth    = 'False',

  $totpcgi_config             = '/etc/totpcgi/totpcgi.conf',
  $totpcgi_owner              = 'root',
  $totpcgi_group              = 'totpcgi',

  $provisioning_config        = '/etc/totpcgi/provisioning.conf',
  $provisioning_owner         = 'root',
  $provisioning_group         = 'totpcgiprov',

  # different backends and respective settings

  # secret backend
  $secret::engine             = 'file',
  $secret::secrets_dir        = '/etc/totpcgi/totp',
  $secret::pg_connect_string  = 'user= password= host= dbname=',
  $secret::mysql_connect_host = '',
  $secret::mysql_connect_user = '',
  $secret::mysql_connect_password = '',
  $secret::mysql_connect_db   = '',
  $secret::ldap_url           = 'ldaps://ipa.example.com:636/',
  $secret::ldap_dn            = 'uid=$username,cn=users,cn=accounts,dc=example,dc=com',
  $secret::ldap_cacert        = '/etc/pki/tls/certs/ipa-ca.crt',

  # pincode backend
  $pincode::engine             = 'file',
  $pincode::usehash            = 'sha256',
  $pincode::makedb             = 'True',
  $pincode::pincode_file       = '/etc/totpcgi/pincodes',
  $pincode::pg_connect_string  = 'user= password= host= dbname=',
  $pincode::mysql_connect_host = '',
  $pincode::mysql_connect_user = '',
  $pincode::mysql_connect_password = '',
  $pincode::mysql_connect_db   = '',
  $pincode::ldap_url           = 'ldaps://ipa.example.com:636/',
  $pincode::ldap_dn            = 'uid=$username,cn=users,cn=accounts,dc=example,dc=com',
  $pincode::ldap_cacert        = '/etc/pki/tls/certs/ipa-ca.crt',

  # state backend
  $state::engine             = 'file',
  $state::state_dir          = '/var/lib/totpcgi',
  $state::pg_connect_string  = 'user= password= host= dbname=',
  $state::mysql_connect_host = '',
  $state::mysql_connect_user = '',
  $state::mysql_connect_password = '',
  $state::mysql_connect_db   = '',
  $state::ldap_url           = 'ldaps://ipa.example.com:636/',
  $state::ldap_dn            = 'uid=$username,cn=users,cn=accounts,dc=example,dc=com',
  $state::ldap_cacert        = '/etc/pki/tls/certs/ipa-ca.crt',

}
