# Class:: cacti::params
#
#
class cacti::params {
  $cacti_dir     = '/usr/share/cacti'
  $cli_dir       = "${cacti_dir}/cli"
  $server        = false
  $ensure        = 'present'
  $ip            = undef
  $disable       = 0
  $description   = undef
  $template      = 8
  $notes         = ''
  $avail         = 'snmp'
  $ping_method   = 'tcp'
  $ping_port     = 161
  $ping_retries  = 2
  $version       = 2
  $port          = 161
  $timeout       = 500
  $community     = 'mgmtcacti'
  $username      = ''
  $password      = ''
  $authproto     = ''
  $privpass      = ''
  $privproto     = ''
  $host          = undef
  $graphtype     = undef
  $graphtemplate = undef
  $field         = ''
  $snmpquery     = ''
  $snmptype      = ''
  $snmpvalue     = ''
  $reindexmethod = ''
} # Class:: cacti::params

