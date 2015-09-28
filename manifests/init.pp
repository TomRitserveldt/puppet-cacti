class cacti(
  $cli_dir = $cacti::params::cli_dir,
  $ensure  = $cacti::params::ensure,
) inherits cacti::params {

  package { "cacti" :
        ensure => $ensure,
  }

  file { "${cli_dir}/remove_device.php":
    ensure => present,
    source => 'puppet:///modules/cacti/remove_device.php',
  }

  file { "/usr/share/cacti/scripts":
    ensure => directory,
  } ->
  file { "/usr/share/cacti/scripts/cactigraph.sh":
    ensure => present,
    source => 'puppet:///modules/cacti/cactigraph.sh',
  }


}
