class cacti(
  $cli_dir = '/usr/share/cacti/cli',
) {

  package { "cacti" :
        ensure => installed,
  }

  file { "${cli_dir}/remove_device.php":
    ensure => present,
    source => 'puppet:///modules/cacti/remove_device.php',
  }

}
