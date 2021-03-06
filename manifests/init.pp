# Class:: cacti
#
# This class handles installing and configuring the cacti server.
# You can add new hosts and graphs with this module by using resources (cacti::host , cacti::graph).
#
# When adding a new host or device you can assign it to an existing tree in cacti, this is done when defining
# the new host.
#
# You can also add new trees in cacti by using the cacti::tree resource. You can re-assign hosts defined in puppet(with exported resources) to another tree.
#
#
# See below for examples
#
# === Parameters:
# [*install_dir*]
#   The base location where cacti is installed, only change this if you specifically installed
#   cacti to another location.
#   Default: '/usr/share/cacti'
#
# [*cli_dir*]
#   The base location for cacti cli files, this is usually a cli folder in the base dir.
#   You should'nt change this unless you moved to another folder,
#   or want to use your own cli directory.
#   Default: ${install_dir}/cli
#
# [*server*]
#   Wether or not to install the cacti server, set to true to install cacti.
#   Default:  false
#
# [*ensure*]
#   This is used for the host resource to determine if a host should be made and be present or not.
#   If set to 'absent' it will remove the host (device + graphs) from cacti.
#   Default:  'present'
#
# [*ip*]
#   This is the ip address of the host to add in cacti.
#   Default:  none
#
# [*disable*]
#   Disables a host in cacti. (but it is not removed)
#   Default:  0
#
# [*description*]
#   Name or description of the resource in cacti.
#   Default:  none
#
# [*template*]
#   Name of the template required to add the new host to cacti.
#   Default:  none
#
# [*notes*]
#   Default:  none
#
# [*avail*]
#   How cacti checks host availability (snmp is the default here).
#   Default:  'snmp'
#
# [*ping_method*]
#   Default:  'tcp'
#
# [*ping_port*]
#   Default:  161
#
# [*ping_retries*]
#   Default:  2
#
# [*version*]
#   The snmp version to use
#   Default:  2
#
# [*port*]
#   The port used for snmp
#   Default:  161
#
# [*timeout*]
#   Default:  500
#
# [*community*]
#   snmp community to use
#   Default:  'mgmtcacti'
#
# [*username*]
#   snmp username
#   Default:  none
#
# [*password*]
#   snmp password
#   Default:  none
#
# [*authproto*]
#   Default:  none
#
# [*privpass*]
#   Default:  none
#
# [*privproto*]
#   Default:  none
#
# [*host*]
#   Default:  none
#
# [*graphtype*]
#   the graph type you want to add,possible values are cg or ds.
#   Default:  none
#
# [*graphtemplate*]
#   Name of the graph template required to add the new graph to cacti.
#   Default:  none
#
# [*field*]
#   Default:  none
#
# [*snmpquery*]
#   Default:  none
#
# [*snmptype*]
#   Default:  none
#
# [*snmpvalue*]
#   Default:  none
#
# [*reindexmethod*]
#   Default:  none
#
# [*filename*]
#  In order to import a template, specify the template filename( this should be located in cacti_basedir/scripts/* )
#  Default: none
#
# [*tree_type*]
#  you should not change this, since you will automatically use the node tree type when you add a new device.
#  Default: tree
#
# [*sort_method*]
#  The desired sort method for the new tree, options are: [manual|alpha|natural|numeric]
#  Default: numeric
#
# [*tree_id*]
#  the name or id of the tree you want to assign a host to.
#  Default: none
#
# [*node_type*]
#  the type of node you want to assign to a tree, options are:[header|host|graph]
#  Default: host
#
# [*parent_node*]
#  the id of the parent node.
#  Default: none
#
# [*host_group_s*]
#  The host group style, options are: [1: graph template,2: data query index]
#  Default: none
#
# [*ro_network*]
#  The network address for snmp
#  Default: 192.168.0.0/16
#
# [*db_type*]
#  Used database type
#  Default: mysql
#
# [*db_name*]
#  Database name
#  Default: cacti
#
# [*db_user*]
#  Database username
#  Default: cacti
#
# [*db_host*]
#  Database host
#  Default: localhost
#
# [*db_port*]
#  Database port
#  Default: 3306
#
# [*db_password*]
#  Database password for db_user
#  Default: none, generated
#
# === Actions:
#
# Installs the cacti package, service, and configuration when server is true.
# adds new hosts, trees and graphs to cacti
#
# === Requires:
#
# snmp module: razorsedge/puppet-snmp
# mysql module
#
# === Sample Usage:
#
#  class { '::cacti':
#    server     => true,
#    community  => 'mgmtcacti1',
#    ro_network => '192.168.0.0/16',
#  }
#  cacti::tree { 'testTree':
#    sort_method => 'numeric',
#  }
#  cacti::host { 'cacti-master':
#    ip       => '192.168.50.33',
#    template => 'Local Linux Machine',
#    tree_id  => 'test',
#    require  => Cacti::Tree['testTree'],
#  }
#
#
class cacti(
  $install_dir   = $cacti::params::install_dir,
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
  $filename      = $cacti::params::filename,
  $tree_type     = $cacti::params::tree_type,
  $sort_method   = $cacti::params::sort_method,
  $tree_id       = $cacti::params::tree_id,
  $node_type     = $cacti::params::node_type,
  $parent_node   = $cacti::params::parent_node,
  $host_group_s  = $cacti::params::host_group_s,
  $ro_network    = $cacti::params::ro_network,
  $db_type       = $cacti::params::db_type,
  $db_name       = $cacti::params::db_name,
  $db_user       = $cacti::params::db_user,
  $db_host       = $cacti::params::db_host,
  $db_port       = $cacti::params::db_port,
  $db_password   = $cacti::params::db_password,
) inherits cacti::params {

  if $server {
    class { '::cacti::server':
      ensure => 'present',
    }
  }

  class { '::snmp':
    agentaddress => [ 'udp:161', 'udp6:161' ],
    ro_community => $community,
    ro_network   => $ro_network,
  }
}
