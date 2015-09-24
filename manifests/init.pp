class cacti(
  $cli_dir = '/usr/share/cacti/cli',
  $ensure  = present,
) {

  package { "cacti" :
        ensure => $ensure,
  }

  file { "${cli_dir}/remove_device.php":
    ensure => present,
    source => 'puppet:///modules/cacti/remove_device.php',
  }

}
