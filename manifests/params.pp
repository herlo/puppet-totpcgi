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
  $install_totpcgi    = true
  $install_qrcode     = true
  $require_pincode    = 'False'
  $success_string     = 'OK'
  $encrypt_secret     = 'False'
  $window_size        = '3'
  $rate_limit         = '3, 30'
  $scratch_tokens_n   = '5'
  $bits               = '80'
  $totp_user_mask     = '$username@example.com'
  $action_url         = '/index.cgi'
  $css_root           = '/'
  $templates_dir      = '/etc/totpcgi/templates'
  $trust_http_auth    = 'False'

  $totpcgi_config             = '/etc/totpcgi/totpcgi.conf'
  $totpcgi_owner              = 'root'
  $totpcgi_group              = 'totpcgi'

  $provisioning_config        = '/etc/totpcgi/provisioning.conf'
  $provisioning_owner         = 'root'
  $provisioning_group         = 'totpcgiprov'

  # different backends and respective settings

  # secret backend
  $secret_engine             = 'file'
  $secret_secrets_dir        = '/etc/totpcgi/totp'
  $secret_pg_connect_string  = 'user= password= host= dbname='
  $secret_mysql_connect_host = ''
  $secret_mysql_connect_user = ''
  $secret_mysql_connect_password = ''
  $secret_mysql_connect_db   = ''
  $secret_ldap_url           = 'ldaps://ipa.example.com:636/'
  $secret_ldap_dn            = 'uid=$username,cn=users,cn=accounts,dc=example,dc=com'
  $secret_ldap_cacert        = '/etc/pki/tls/certs/ipa-ca.crt'

  # pincode backend
  $pincode_engine             = 'file'
  $pincode_usehash            = 'sha256'
  $pincode_makedb             = 'True'
  $pincode_pincode_file       = '/etc/totpcgi/pincodes'
  $pincode_pg_connect_string  = 'user= password= host= dbname='
  $pincode_mysql_connect_host = ''
  $pincode_mysql_connect_user = ''
  $pincode_mysql_connect_password = ''
  $pincode_mysql_connect_db   = ''
  $pincode_ldap_url           = 'ldaps://ipa.example.com:636/'
  $pincode_ldap_dn            = 'uid=$username,cn=users,cn=accounts,dc=example,dc=com'
  $pincode_ldap_cacert        = '/etc/pki/tls/certs/ipa-ca.crt'

  # state backend
  $state_engine             = 'file'
  $state_state_dir          = '/var/lib/totpcgi'
  $state_pg_connect_string  = 'user= password= host= dbname='
  $state_mysql_connect_host = ''
  $state_mysql_connect_user = ''
  $state_mysql_connect_password = ''
  $state_mysql_connect_db   = ''
  $state_ldap_url           = 'ldaps://ipa.example.com:636/'
  $state_ldap_dn            = 'uid=$username,cn=users,cn=accounts,dc=example,dc=com'
  $state_ldap_cacert        = '/etc/pki/tls/certs/ipa-ca.crt'

}
