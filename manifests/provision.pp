
define totpcgi::provision::manual (
  $encoded_secret,
  $tokens,
) {

  file { "${totpcgi::secrets_dir}/${name}.totp":
    ensure  => file,
    owner   => ${totpcgi::totpcgiprov_owner},
    group   => ${totpcgi::totcpgi_group},
    mode    => '0440',
    content => template('totpcgi/secrets.totp.erb')
  }
}
