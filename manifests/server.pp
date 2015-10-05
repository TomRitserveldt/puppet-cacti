# Class:: cacti::server
# Installs cacti on the machine.
#
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

  Cacti::Tree <<| title != undef |>>
  Cacti::Host <<| title != undef |>>
  Cacti::Device <<| title != undef |>>
  Cacti::Graph <<| title != undef |>>
}
