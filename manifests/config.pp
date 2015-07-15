

class totpcgi::config inherits totpcgi {

  file { "$totpcgi_config":
    ensure  => file,
    owner   => $totpcgi_owner,
    group   => $totpcgi_group,
    mode    => '0640',
    content => template('totpcgi/totpcgi.conf.erb'),
  }

  file { "$provisioning_config":
    ensure  => file,
    owner   => $provisioning_owner,
    group   => $provisioning_group,
    mode    => '0640',
    content => template('totpcgi/provisioning.conf.erb'),
  }

}

