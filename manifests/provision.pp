
define totpcgi::provision::manual (
  $values,
) {

  file { "${secrets_dir}/${name}.totp":
    ensure  => directory,
    owner   => $totpcgiprov_owner,
    group   => $totcpgi_group,
    mode    => '0440',
    content => template('totpcgi/secrets.totp.erb')
  }
}
