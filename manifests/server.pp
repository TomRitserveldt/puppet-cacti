class cacti::server {

  package { "cacti" :
          ensure => $ensure,
  } ->
  
  include ::apache

  Cacti::Host <<| title!= undef |>>
  Cacti::Device <<| title != undef |>>
  Cacti::Graph <<| title != undef |>>

}
