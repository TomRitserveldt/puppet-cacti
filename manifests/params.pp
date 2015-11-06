# Class:: cacti::params
#
#
class cacti::params {
  $install_dir   = '/usr/share/cacti'
  $cli_dir       = "${install_dir}/cli"
  $server        = false
  $ensure        = 'present'
  $ip            = undef
  $disable       = 0
  $description   = undef
  $template      = 8
  $notes         = undef
  $avail         = 'snmp'
  $ping_method   = 'tcp'
  $ping_port     = 161
  $ping_retries  = 2
  $version       = 2
  $port          = 161
  $timeout       = 500
  $community     = 'mgmtcacti'
  $username      = undef
  $password      = undef
  $authproto     = undef
  $privpass      = undef
  $privproto     = undef
  $host          = undef
  $graphtype     = undef
  $graphtemplate = undef
  $field         = undef
  $snmpquery     = undef
  $snmptype      = undef
  $snmpvalue     = undef
  $reindexmethod = undef
  $filename      = undef
  $tree_type     = 'tree'
  $sort_method   = 'numeric'
  $tree_id       = undef
  $node_type     = 'host'
  $parent_node   = undef
  $host_group_s  = '1'
  $ro_network    = '192.168.0.0/16'
} # Class:: cacti::params

