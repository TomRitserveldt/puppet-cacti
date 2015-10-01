# Class:: cacti
#
# This class handles installing and configuring the cacti server.
# You can add new hosts and graphs with this module by using resources (cacti::host , cacti::graph).
#
# See below for examples
#
# === Parameters:
# [*cacti_dir*]  
#   The base location where cacti is installed, only change this if you specifically installed 
#   cacti to another location.   
#   Default: '/usr/share/cacti'
#
# [*cli_dir*]
#   The base location for cacti cli files, this is usually a cli folder in the base dir.
#   You should'nt change this unless you moved to another folder, 
#   or want to use your own cli directory.
#   Default: ${cacti_dir}/cli
#
# [* server *]
#   Wether or not to install the cacti server, set to true to install cacti.
#   Default:  false
#
# [* ensure *]
#   This is used for the host resource to determine if a host should be made and be present or not. 
#   If set to 'absent' it will remove the host (device + graphs) from cacti.
#   Default:  'present'
#
# [* ip *]
#   This is the ip address of the host to add in cacti.
#   Default:  none
#
# [* disable *]
#   Disables a host in cacti. (but it is not removed)
#   Default:  0
#
# [* description *]
#   Name or description of the resource in cacti.
#   Default:  none
#
# [* template *]
#   Name of the template required to add the new host to cacti.
#   Default:  none
#
# [* notes *]
#   Default:  none
#
# [* avail *]
#   Default:  'snmp'
#
# [* ping_method *]
#   Default:  'tcp'
#
# [* ping_port *]
#   Default:  161
#
# [* ping_retries *]
#   Default:  2
#
# [* version *]
#   Default:  2
#
# [* port *]
#   Default:  161
#
# [* timeout *]
#   Default:  500
#
# [* community *]
#   snmp community
#   Default:  'mgmtcacti'
#
# [* username *]
#   snmp username
#   Default:  none
#
# [* password *]
#   snmp password
#   Default:  none
#
# [* authproto *]
#   Default:  none
#
# [* privpass *]
#   Default:  none
#
# [* privproto *]
#   Default:  none
#
# [* host *]
#   Default:  none
#
# [* graphtype *]
#   Default:  none
#
# [* graphtemplate *]
#   Name of the template required to add the new graph to cacti.
#   Default:  none
#
# [* field *]
#   Default:  none
#
# [* snmpquery *]
#   Default:  none
#
# [* snmptype *]
#   Default:  none
#
# [* snmpvalue *]
#   Default:  none
#
# [* reindexmethod *]
#   Default:  none
#
# === Actions:
#
# Installs the cacti package, service, and configuration when server is true.
# adds new hosts and graphs to cacti
#
# === Requires:
#
# snmp module: razorsedge/puppet-snmp 
# mysql module
#
# === Sample Usage:
#
#  install and configure a cacti server
#  class { '::cacti':
#    server => true,
#  }
#  
#  add a new host to the cacti server
#  @@cacti::host { 'cacti-master':
#    ip       => '192.168.50.33',
#    template => 'Local Linux Machine',  
#  }
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
  $reindexmethod = $cacti::params::reindexmethod,
) inherits cacti::params {

  if $server {
    class { 'cacti::server':
      ensure => 'present',
    }
  } elsif !$server {
    class { 'cacti::server':
      ensure => 'absent',
    }
  }

  file { "${cli_dir}/remove_device.php":
    ensure => present,
    source => 'puppet:///modules/cacti/remove_device.php',
  }

  file { '/usr/share/cacti/scripts':
    ensure => directory,
  }
  file { '/usr/share/cacti/scripts/cactigraph.sh':
    ensure => present,
    owner  => root,
    mode   => '0755',
    source => 'puppet:///modules/cacti/cactigraph.sh',
  }
  
  class { '::snmp':
    agentaddress => [ 'udp:161', 'udp6:161' ],
  }

}
