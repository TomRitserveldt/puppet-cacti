# == Definition: cacti::device
#
define cacti::device (
  $ip           = undef,
  $ensure       = 'present',
  $disable      = 0,
  $description  = undef,
  $template     = 8,
  $notes        = '',
  $disable      = 0,
  $avail        = 'snmp',
  $ping_method  = 'tcp',
  $ping_port    = 161,
  $ping_retries = 2,
  $version      = 2,
  $port         = 161,
  $timeout      = 500,
  $community    = 'mgmtcacti',
  $username     = '',
  $password     = '',
  $authproto    = '',
  $privpass     = '',
  $privproto    = ''
) {



}
