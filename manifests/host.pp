# == Definition: cacti::host
#
define cacti::host (
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

  # fails when no name/title is provided
  if $name == '' {
    fail('Can not create a host with empty title/name')
  } else {
    $description = $name
  }


  # Make a new device and some default graphs
  cacti::device { $name:
    ip           => $ip,
    description  => $description,
    template     => $template,
    notes        => $notes,
    disable      => $disable,
    avail        => $avail,
    ping_method  => $ping_method,
    ping_port    => $ping_port,
    ping_retries => $ping_retries,
    version      => $version,
    port         => $port,
    timeout      => $timeout,
    community    => $community,
    username     => $username,
    password     => $password,
    authproto    => $authproto,
    privpass     => $privpass,
    privproto    => $privproto
  }


  cacti::graph { "Load Average ${name}":
    host          => $name,
    graphtype     => 'cg',
    graphtemplate => 'Unix - Load Average',
    require       =>  Cacti::Add_device[$name],
  }


}
