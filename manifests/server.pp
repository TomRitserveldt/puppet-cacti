# Class:: cacti::server
# Installs cacti on the machine.
# [*ensure*]
#   sets if cacti server should be installed or not, this is determined in the init class.
#   Default: none
class cacti::server(
  $ensure = $ensure,
) {

  $install_dir = $::cacti::install_dir

  $db_type     = $::cacti::db_type
  $db_name     = $::cacti::db_name
  $db_user     = $::cacti::db_user
  $db_host     = $::cacti::db_host
  $db_port     = $::cacti::db_port
  $db_password = $::cacti::db_password

  if !$db_password {
    $rnd = fqdn_rand(999999999)
    $real_db_password = md5("${rnd}${::fqdn}")
  }
  else {
    $real_db_password = $db_password
  }

  include ::mysql::server

  package { 'cacti' :
    ensure => $ensure,
  }

  file { [
      "${::cacti::install_dir}/scripts",
      "${::cacti::install_dir}/conf_templates",
      ]:
    ensure  => directory,
    owner   => 'root',
    mode    => '0755',
    require => Package['cacti'],
  }

  file { "${::cacti::cli_dir}/remove_device.php":
    ensure  => file,
    owner   => 'root',
    mode    => '0755',
    group   => 'root',
    source  => 'puppet:///modules/cacti/remove_device.php',
    require => Package['cacti'],
  }

  file { "${::cacti::install_dir}/scripts/cactigraph.sh":
    ensure  => file,
    owner   => 'root',
    mode    => '0755',
    group   => 'root',
    source  => 'puppet:///modules/cacti/cactigraph.sh',
    require => Package['cacti'],
  }

  file { "${::cacti::install_dir}/scripts/cactitree.sh":
    ensure  => file,
    owner   => 'root',
    mode    => '0755',
    group   => 'root',
    source  => 'puppet:///modules/cacti/cactitree.sh',
    require => Package['cacti'],
  }

  file { "${::cacti::install_dir}/scripts/cactiversion.sh":
    ensure  => file,
    owner   => 'root',
    mode    => '0755',
    group   => 'root',
    content => template('cacti/cactiversion.sh.erb'),
    require => Package['cacti'],
  }

  file { 'temp import file for cacti conf':
    ensure  => file,
    path    => "${::cacti::install_dir}/conf_templates/test1.sql",
    content => template('cacti/cacti.sql.erb'),
    require => Package['cacti'],
  }

  # We should not do this if $db_host is not 'localhost'
  ::mysql::db { $db_name:
    user           => $db_user,
    password       => $real_db_password,
    host           => 'localhost',
    grant          => ['SELECT', 'INSERT', 'UPDATE', 'DELETE', 'CREATE', 'DROP'],
    sql            => "${::cacti::install_dir}/conf_templates/test1.sql",
    import_timeout => 900,
    require        => File['temp import file for cacti conf'],
  }

  file { "${::cacti::install_dir}/site/include/config.php":
    ensure  => file,
    owner   => 'root',
    mode    => '0644',
    group   => 'root',
    content => template('cacti/config.php.erb'),
    require => Package['cacti'],
  }

  exec { 'set_cactiversion':
    command     => "${::cacti::install_dir}/scripts/cactiversion.sh",
    subscribe   => Mysql::Db['cacti'],
    refreshonly => true,
  }

  Cacti::Tree <<| |>>
  Cacti::Host <<| |>>
  Cacti::Device <<| |>>
  Cacti::Graph <<| |>>
}
