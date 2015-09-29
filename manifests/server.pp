class cacti::server {

  package { "cacti" :
          ensure => $ensure,
  }

  Cacti::Host <<| title!= undef |>>
  Cacti::Device <<| title != undef |>>
  Cacti::Graph <<| title != undef |>>
  include ::apache
}
