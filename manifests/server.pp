# Class:: cacti::server
# Installs cacti on the machine.
# [*ensure*]
#   sets if cacti server should be installed or not, this is determined in the init class.
#   Default: none
class cacti::server(
  $ensure = $ensure,
) {

  include ::mysql::server

  package { 'cacti' :
    ensure => $ensure,
  }

  file { 'temp import file for cacti conf':
    ensure  => file,
    path    => '/usr/share/cacti/conf_templates/test1.sql',
    content => template('cacti/cacti.sql.erb'),
    require => Package['cacti'],
  }

  ::mysql::db { 'cacti':
    user           => 'root',
    password       => '',
    host           => 'localhost',
    grant          => ['SELECT', 'INSERT', 'UPDATE', 'DELETE', 'CREATE', 'DROP'],
    sql            => '/usr/share/cacti/conf_templates/test1.sql',
    import_timeout => 900,
    require        => File['temp import file for cacti conf'],
  }
file { "${cli_dir}/remove_device.php":
    ensure => file,
    owner  => root,
    mode   => '0755',
    group  => root,
    source => 'puppet:///modules/cacti/remove_device.php',
  }

  file { '/usr/share/cacti/scripts':
    ensure => directory,
    owner  => root,
    mode   => '0755',
  }
  file { '/usr/share/cacti/scripts/cactigraph.sh':
    ensure => file,
    owner  => root,
    mode   => '0755',
    group  => root,
    source => 'puppet:///modules/cacti/cactigraph.sh',
  }

  file { '/usr/share/cacti/scripts/cactitree.sh':
    ensure => file,
    owner  => root,
    mode   => '0755',
    group  => root,
    source => 'puppet:///modules/cacti/cactitree.sh',
  }

  Cacti::Tree <<| |>>
  Cacti::Host <<| |>>
  Cacti::Device <<| |>>
  Cacti::Graph <<| |>>
}
