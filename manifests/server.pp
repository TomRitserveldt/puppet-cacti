class cacti::server {

  package { "cacti" :
          ensure => $ensure,
  } ->
  service { 'httpd':
    ensure     => running,
    enable     => true,
  }
  Cacti::Host <<| title!= undef |>>
  Cacti::Device <<| title != undef |>>
  Cacti::Graph <<| title != undef |>>

}
