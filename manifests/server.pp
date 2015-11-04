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

  file { [
      "${::cacti::cacti_dir}/scripts",
      "${::cacti::cacti_dir}/conf_templates",
      ]:
    ensure => directory,
    owner  => root,
    mode   => '0755',
  }

  file { "${::cacti::cli_dir}/remove_device.php":
    ensure => file,
    owner  => root,
    mode   => '0755',
    group  => root,
    source => 'puppet:///modules/cacti/remove_device.php',
  }

  file { "${::cacti::cacti_dir}/scripts/cactigraph.sh":
    ensure => file,
    owner  => root,
    mode   => '0755',
    group  => root,
    source => 'puppet:///modules/cacti/cactigraph.sh',
  }

  file { "${::cacti::cacti_dir}/scripts/cactitree.sh":
    ensure => file,
    owner  => root,
    mode   => '0755',
    group  => root,
    source => 'puppet:///modules/cacti/cactitree.sh',
  }

  file { 'temp import file for cacti conf':
    ensure  => file,
    path    => "${::cacti::cacti_dir}/conf_templates/test1.sql",
    content => template('cacti/cacti.sql.erb'),
    require => Package['cacti'],
  }

  ::mysql::db { 'cacti':
    user           => 'root',
    password       => '',
    host           => 'localhost',
    grant          => ['SELECT', 'INSERT', 'UPDATE', 'DELETE', 'CREATE', 'DROP'],
    sql            => "${::cacti::cacti_dir}/conf_templates/test1.sql",
    import_timeout => 900,
    require        => File['temp import file for cacti conf'],
  }

  Cacti::Tree <<| |>>
  Cacti::Host <<| |>>
  Cacti::Device <<| |>>
  Cacti::Graph <<| |>>
}
