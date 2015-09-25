# == Definition: cacti::host
#
define cacti::host (
  $ip           = $cacti::params::ip ,
  $ensure       = $cacti::params::ensure,
  $disable      = $cacti::params::disable,
  $description  = $cacti::params::description,
  $template     = $cacti::params::template,
  $notes        = $cacti::params::notes,
  $disable      = $cacti::params::disable,
  $avail        = $cacti::params::avail,
  $ping_method  = $cacti::params::ping_method,
  $ping_port    = $cacti::params::ping_port,
  $ping_retries = $cacti::params::ping_retries,
  $version      = $cacti::params::version,
  $port         = $cacti::params::port,
  $timeout      = $cacti::params::timeout,
  $community    = $cacti::params::community,
  $username     = $cacti::params::username,
  $password     = $cacti::params::password,
  $authproto    = $cacti::params::authproto,
  $privpass     = $cacti::params::privpass,
  $privproto    = $cacti::params::privproto
) inherits cacti::params {

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
    require       =>  Cacti::device[$name],
  }


}
