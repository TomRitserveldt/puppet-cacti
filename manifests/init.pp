# Class:: cacti
#
#
class cacti(
  $cacti_dir     = $cacti::params::cacti_dir,
  $cli_dir       = $cacti::params::cli_dir,
  $server        = $cacti::params::server,  
  $ensure        = $cacti::params::ensure,
  $ip            = $cacti::params::ip,
  $disable       = $cacti::params::disable,
  $description   = $cacti::params::description,
  $template      = $cacti::params::template,
  $notes         = $cacti::params::notes,
  $avail         = $cacti::params::avail,
  $ping_method   = $cacti::params::ping_method,
  $ping_port     = $cacti::params::ping_port,
  $ping_retries  = $cacti::params::ping_retries,
  $version       = $cacti::params::version,
  $port          = $cacti::params::port,
  $timeout       = $cacti::params::timeout,
  $community     = $cacti::params::community,
  $username      = $cacti::params::username,
  $password      = $cacti::params::password,
  $authproto     = $cacti::params::authproto,
  $privpass      = $cacti::params::privpass,
  $privproto     = $cacti::params::privproto,
  $host          = $cacti::params::host,
  $graphtype     = $cacti::params::graphtype,
  $graphtemplate = $cacti::params::graphtemplate,
  $field         = $cacti::params::field,
  $snmpquery     = $cacti::params::snmpquery,
  $snmptype      = $cacti::params::snmptype,
  $snmpvalue     = $cacti::params::snmpvalue,
  $reindexmethod = $cacti::params::reindexmethod
) inherits cacti::params {

  if $server == true {
    include cacti::server
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
    owner  => root,
    mode   => '0755',
    source => 'puppet:///modules/cacti/cactigraph.sh',
  }
  
  class { '::snmp':
    agentaddress => [ 'udp:161', 'udp6:161' ],
  }

}
