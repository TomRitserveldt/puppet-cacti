class cacti::server {
  
  include ::mysql::server
  package { "cacti" :
          ensure => $ensure,
  } ->
  file { "temp import file for cacti conf":
      ensure => file,
      path   => '/usr/share/cacti/conf_templates/test1.sql',
      content => template('cacti.sql.erb'),
      require => Package["cacti"],
  }->
  ::mysql::db { 'cacti':
  user     => 'root',
  password => '',
  host     => 'localhost',
  grant    => ['SELECT', 'INSERT', 'UPDATE', 'DELETE', 'CREATE', 'DROP'],
  sql      => '/usr/share/cacti/conf_templates/test1.sql',
  import_timeout => 900,
  require  => File["temp import file for cacti conf"],
  }

  Cacti::Host <<| title!= undef |>>
  Cacti::Device <<| title != undef |>>
  Cacti::Graph <<| title != undef |>>
}
