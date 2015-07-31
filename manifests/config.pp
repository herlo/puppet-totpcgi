

class totpcgi::config inherits totpcgi {

  file { "$totpcgi_config_dir":
    ensure  => directory,
    owner   => $provisioning_owner,
    group   => $totpcgi_group,
    mode    => '0750',
  }

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

  if $secret_engine == "file" {
    file { "$secrets_dir":
      ensure  => directory,
      owner   => $provisioning_owner,
      group   => $totpcgi_group,
      mode    => '0750',
    }
  }

  if $pincode_engine == "file" {
    file { "$pincode_file":
      ensure  => file,
      owner   => 'root',
      group   => $totpcgi_group,
      mode    => '0640',
    }
  }

  if $pincode_engine == "ldap" {
    file { "$pincode_ldap_cacert":
      ensure  => file,
    }
  }

  if $state_engine == "file" {
    file { "$state_dir":
      ensure  => directory,
      owner   => $provisioning_owner,
      group   => $totpcgi_group,
      mode    => '0770',
    }
  }

  if $broken_selinux_python_policy{
      selinux::module { 'mytotpcgi':
        notify => Selmodule['mytotpcgi'],
        source => 'puppet:///modules/totpcgi/mytotpcgi.te'
      }

      selmodule { 'mytotpcgi':
        ensure      => present,
        syncversion => true,
      }
  }

}

