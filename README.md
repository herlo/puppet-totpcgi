# puppet-totpcgi

[![Build Status](https://travis-ci.org/herlo/puppet-totpcgi.png)](https://travis-ci.org/herlo/puppet-totpcgi)

This module manages the configuration of https://github.com/mricon/totp-cgi.
It includes a server component and client components. The only current module
is for sudo.

===

# Compatibility

This module has been tested to work on the following systems using Puppet v4 with Ruby version 2.0.0.

 * EL 7

===
# Dependencies

## Forge Modules

* mthibaut/users >=v1.0.11
* puppetlabs/apache', >=1.5.0
* camptocamp/selinux, >=0.1.19 (should go away with a proper
  fix to the el7 selinux policy)

## Github Repos (for one reason or another)

* https://github.com/herlo/puppet-module-pam
  (a fork with a few improvements from ghoneycut/pam)
  See https://github.com/ghoneycutt/puppet-module-pam/pull/115
  for current status of PR.
* https://github.com/herlo/puppet-module-nsswitch.git
  (a fork with a few improvements from ghoneycut/nsswitch)
  *required by puppet-module-pam

===

# Parameters

## totpcgi server configurations

All configurations are represnted as 'totpcgi::<parameter>'

install_totpcgi
-------------
Boolean determining wether this module will manage the installation of the
totpcgi, totpcgi-selinux, and totpcgi-provisioning packages.

- *Default*: true

install_qrcode
----------------
Whether this module will manage the installation of the
python-qrcode package. This package is used to display
qrcodes for adding pincodes.

- *Default*: true

provisioning
---------------
provisions new pincode accounts  The options are 'manual' and 'automatic'

'automatic' is not yet supported.

- *Default*: 'manual'

require_pincode
---------------
String (which the config reads as a boolean) whether to also require
a pincode (or password).

- *Default*: 'False'

success_string
---------------
String returned from the totpcgi service indicating successful validation
of token.

- *Default*: 'OK'

encrypt_secret
---------------
Whether to encrypt the master secret for totp codes.

**NOTE**: It's important to realize that this comes with a trade-off --
if a client forgets their pincode, the TOTP token will need to be re-provisioned.

- *Default*: 'False'

tokens
-----
If the $provisioning value is set to 'manual', this construct creates the
token files.

See https://github.com/lfit/totp-cgi/blob/master/INSTALL.rst#provisioning-cgi

- *Default*: undef

# Hiera example for totpcgi::users
<pre>
totpcgi::tokens:
  bob:
    encoded_secret: '2AA348X9K27GH0B4'
    tokens:
      - '01234567'
      - '12345678'
      - '23456789'
      - '34567890'
      - '45678901'
</pre>

window_size
------------
String, see https://github.com/google/google-authenticator/blob/master/libpam/FILEFORMAT

- *Default*: '3'

rate_limit
----------
String, see https://github.com/google/google-authenticator/blob/master/libpam/FILEFORMAT

- *Default*: '3 30'

disallow_reuse
---------------
Boolean, see https://github.com/google/google-authenticator/blob/master/libpam/FILEFORMAT

- *Default*: true

totp_auth
---------
Boolean, see https://github.com/google/google-authenticator/blob/master/libpam/FILEFORMAT

- *Default*: true

hotp_counter
------------
String, see https://github.com/google/google-authenticator/blob/master/libpam/FILEFORMAT

- *Default*: undef

scratch_tokens_n
----------------
The default number of scratch tokens included in the user.totp file.

- *Default*: '5'

bits
----
How many bits in a generated secret.

- *Default*: '80'

totp_user_mask
---------------
Identifies the token in the Google Authenticator application. The '$username'
is interpolated at provisioning. Useful when users have more than one token.

- *Default*: '$username@example.com'

totpcgi_config_dir
------------------
Where totpcgi configuration files live.

- *Default*: '/etc/totpcgi'

totpcgi_config
----------------
The path to the totpcgi.conf

- *Default*: '$totpcgi_config_dir/totpcgi.conf

totpcgi_owner / totpcgi_group
-----------------------------
The owner and group for the $totpcgi_config mentioned above.

- *Default*: 'totpcgi'

provisioning_config
-------------------
The path to the provisioning.conf

- *Default*: '$totpcgi_config_dir/provisioning.conf

provisioning_owner / provisioning_group
-----------------------------------------
The owner and group for the $provisioning_config mentioned above.

- *Default*: 'totpcgiprov'

## The following are set in both totpcgi_config and provisioning_config

secret_engine
---------------
Engine where totp secrets are stored. The options are:
* 'file'
* 'pgsql'
* 'mysql'

- *Default*: 'file'

secrets_dir
---------------
When using 'file' for the $secret_engine, this will be the path holding
the <username>.totp files with secrets.

- *Default*: '$totpcgi_config_dir/totp'

secret_pg_connect_string
------------------------
When using 'pgsql' for the $secret_engine, this will be the connection
string to the postgresql database.

- *Default*: 'user= password= host= dbname='

secret_mysql_connect_host
-------------------------
When using 'mysql' for the $secret_engine, this will be the mysql host.

- *Default*: undef

secret_mysql_connect_user
-------------------------
When using 'mysql' for the $secret_engine, this will be the user.

- *Default*: undef

secret_mysql_connect_pass
---------------------------
When using 'mysql' for the $secret_engine, this will be the password.

- *Default*: undef

secret_mysql_connect_db
-----------------------
When using 'mysql' for the $secret_engine, this will be the database.

- *Default*: undef

pincode_engine
---------------
Engine where totp secrets are stored. The options are:
* 'file'
* 'pgsql'
* 'mysql'
* 'ldap'

- *Default*: 'file'

pincode_usehash
---------------
Default hash verification method.

- *Default*: 'sha256'

pincode_makedb
---------------
Whether to compile the DBM database (only meaningful with the file backend)

- *Default*: 'True'

pincode_file
---------------
When using 'file' for the $pincode_engine, this will be the file holding
username:password-hash values.

- *Default*: '$totpcgi_config_dir/pincodes'

pincode_pg_connect_string
------------------------
When using 'pgsql' for the $pincode_engine, this will be the connection
string to the postgresql database.

- *Default*: 'user= password= host= dbname='

pincode_mysql_connect_host
-------------------------
When using 'mysql' for the $pincode_engine, this will be the mysql host.

- *Default*: undef

pincode_mysql_connect_user
-------------------------
When using 'mysql' for the $pincode_engine, this will be the user.

- *Default*: undef

pincode_mysql_connect_pass
---------------------------
When using 'mysql' for the $pincode_engine, this will be the password.

- *Default*: undef

pincode_mysql_connect_db
-----------------------
When using 'mysql' for the $pincode_engine, this will be the database.

- *Default*: undef

pincode_ldap_url
----------------
When using 'ldap' for the $pincode_engine, this will be the ldap_url.

- *Default*: 'ldaps://ipa.example.com:636/'

pincode_ldap_dn
---------------
When using 'ldap' for the $pincode_engine, this will be the user.

- *Default*: 'uid=$username,cn=users,cn=accounts,dc=example,dc=com'

pincode_ldap_cacert
-------------------
When using 'ldap' for the $pincode_engine, the CA Certificate path.

- *Default*: '/etc/ipa/ca.crt'

state_engine
---------------
Engine where totp secrets are stored. The options are:
* 'file'
* 'pgsql'
* 'mysql'

- *Default*: 'file'

state_file
---------------
When using 'file' for the $state_engine, this will be the state directory.


- *Default*: '/var/lib/totpcgi'

state_pg_connect_string
------------------------
When using 'pgsql' for the $state_engine, this will be the connection
string to the postgresql database.

- *Default*: 'user= password= host= dbname='

state_mysql_connect_host
-------------------------
When using 'mysql' for the $state_engine, this will be the mysql host.

- *Default*: undef

state_mysql_connect_user
-------------------------
When using 'mysql' for the $state_engine, this will be the user.

- *Default*: undef

state_mysql_connect_pass
---------------------------
When using 'mysql' for the $state_engine, this will be the password.

- *Default*: undef

state_mysql_connect_db
-----------------------
When using 'mysql' for the $state_engine, this will be the database.

- *Default*: undef

## provisioning.cgi only configs

action_url
----------
Where the provisioning CGI is located, with regards to the web root.

- *Default*: '/index.cgi'

css_root
--------
CSS files provided to make the provisioning page look good.

- *Default*: '/'

templates_dir
---------------
Where to find the templates files.

- *Default*: '$totpcgi_config_dir/templates'

trust_http_auth
---------------
Whether to rely on HTTP auth to handle authentication. Turning this on
requires setting 'encrypt_secret' to false.

- *Default*: 'False'

## apache vhost configuration
Since totpcgi is a CGI application, it uses a virtualhost, provided by the
puppetlabs/apache module. (See dependencies above)

vhost_name
----------
See https://github.com/puppetlabs/puppetlabs-apache#define-apachevhost

- *Default*: undef

port
----
See https://github.com/puppetlabs/puppetlabs-apache#define-apachevhost

- *Default*: '8443'

servername
----------
See https://github.com/puppetlabs/puppetlabs-apache#define-apachevhost

- *Default*: undef

serveradmin
-----------
See https://github.com/puppetlabs/puppetlabs-apache#define-apachevhost

- *Default*: 'admin@example.com'

docroot
-------
See https://github.com/puppetlabs/puppetlabs-apache#define-apachevhost

- *Default*: undef

suexec_user_group
-----------------
See https://github.com/puppetlabs/puppetlabs-apache

- *Default*: undef

ssl
---
See https://github.com/puppetlabs/puppetlabs-apache#define-apachevhost

- *Default*: true

ssl_certs_dir
---------------
See https://github.com/puppetlabs/puppetlabs-apache#define-apachevhost

- *Default*: 'OK'

ssl_cacert
---------------
See https://github.com/puppetlabs/puppetlabs-apache#define-apachevhost

- *Default*: 'OK'

ssl_cert
--------
See https://github.com/puppetlabs/puppetlabs-apache#define-apachevhost

- *Default*: 'OK'

ssl_key
-------
See https://github.com/puppetlabs/puppetlabs-apache#define-apachevhost

- *Default*: undef

ssl_verify_depth
----------------
See https://github.com/puppetlabs/puppetlabs-apache#define-apachevhost

- *Default*: undef

ssl_verify_client
-----------------
See https://github.com/puppetlabs/puppetlabs-apache#define-apachevhost

- *Default*: undef

error_log_file
---------------
See https://github.com/puppetlabs/puppetlabs-apache#define-apachevhost

- *Default*: undef

access_log_file
---------------
See https://github.com/puppetlabs/puppetlabs-apache#define-apachevhost

- *Default*: undef

directories
---------------
https://github.com/puppetlabs/puppetlabs-apache#parameter-directories-for-apachevhost

- *Default*: undef

## Client only configs (specifically sudo)
All configurations are represented as 'totpcgi::client::<parameter>'

host
----
totpcgi server host fqdn

- *Default*: undef

host_ip
-------
totpcgi server host ip address

- *Default*: undef

pam_url_config
--------------
path to the pam_url.conf

- *Default*: '/etc/pam_url.conf'

pam_url_prompt
--------------
The text prompt given to users when performing sudo actions

- *Default*: 'Token: '
