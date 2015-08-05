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
  $totpcgi_config_dir = '/etc/totpcgi'
  $provisioning       = undef # use 'manual' as 'automatic' is not yet supported
  $require_pincode    = 'False'
  $success_string     = 'OK'
  $encrypt_secret     = 'False'
  $users              = undef
  $window_size        = '3'
  $rate_limit         = '3 30'
  $disallow_reuse     = true
  $totp_auth          = true
  $hotp_counter       = undef
  $scratch_tokens_n   = '5'
  $bits               = '80'
  $totp_user_mask     = '$username@example.com'
  $action_url         = '/index.cgi'
  $css_root           = '/'
  $templates_dir      = "$totpcgi_config_dir/templates"
  $trust_http_auth    = 'False'

  $totpcgi_config             = "$totpcgi_config_dir/totpcgi.conf"
  $totpcgi_owner              = 'totpcgi'
  $totpcgi_group              = 'totpcgi'

  $provisioning_config        = "$totpcgi_config_dir/provisioning.conf"
  $provisioning_owner         = 'totpcgiprov'
  $provisioning_group         = 'totpcgiprov'

  # different backends and respective settings

  # secret backend
  $secret_engine             = 'file'
  $secrets_dir               = "$totpcgi_config_dir/totp"
  $secret_pg_connect_string  = 'user= password= host= dbname='
  $secret_mysql_connect_host = ''
  $secret_mysql_connect_user = ''
  $secret_mysql_connect_password = ''
  $secret_mysql_connect_db   = ''

  # pincode backend
  $pincode_engine             = 'file'
  $pincode_usehash            = 'sha256'
  $pincode_makedb             = 'True'
  $pincode_file               = "$totpcgi_config_dir/pincodes"
  $pincode_pg_connect_string  = 'user= password= host= dbname='
  $pincode_mysql_connect_host = undef
  $pincode_mysql_connect_user = undef
  $pincode_mysql_connect_password = undef
  $pincode_mysql_connect_db   = undef
  $pincode_ldap_url           = 'ldaps://ipa.example.com:636/'
  $pincode_ldap_dn            = 'uid=$username,cn=users,cn=accounts,dc=example,dc=com'
  $pincode_ldap_cacert        = '/etc/ipa/ca.crt'

  # state backend
  $state_engine             = 'file'
  $state_dir                = '/var/lib/totpcgi'
  $state_pg_connect_string  = 'user= password= host= dbname='
  $state_mysql_connect_host = undef
  $state_mysql_connect_user = undef
  $state_mysql_connect_password = undef
  $state_mysql_connect_db   = undef

  # apache configs
  $vhost_name               = undef
  $port                     = '8443'
  $servername               = undef
  $serveradmin              = 'admin@example.com'
  $docroot                  = undef
  $suexec_user_group        = undef
  $ssl                      = true
  $ssl_certs_dir            = undef
  $ssl_cacert               = undef
  $ssl_cert                 = undef
  $ssl_key                  = undef
  $ssl_verify_depth         = undef
  $ssl_verify_client        = undef
  $error_log_file           = undef
  $access_log_file          = undef
  $directories              = undef

  # the totpcgi module is broken by python core libraries,
  # which try to lookup the uid and cause an selinux AVC
  # turning on this variable will enable the temporary
  # policy to fix the problem

  $broken_selinux_python_policy = False

  # client only configs
  $host             = undef
  $host_ip          = undef
  $pam_url_config   = '/etc/pam_url.conf'
  $pam_url_prompt   = "Token: "

}

