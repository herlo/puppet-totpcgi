
class totpcgi::provision (
) inherits totpcgi {

  if $provisioning == 'manual':
    file { "${secrets_dir}/${user}.totp":
      ensure  => directory,
      owner   => $totpcgiprov_owner,
      group   => $totpcgi_group,
      mode    => '0440',
      content => template('totpcgi/secrets.totp.erb')
  }
  # do automated provisioning, currently unsupported

}
