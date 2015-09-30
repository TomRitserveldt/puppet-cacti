# == Definition: cacti::host
#
define cacti::host (
  $ip           = $cacti::ip,
  $ensure       = $cacti::ensure,
  $disable      = $cacti::disable,
  $description  = $name,
  $template     = $cacti::template,
  $notes        = $cacti::notes,
  $disable      = $cacti::disable,
  $avail        = $cacti::avail,
  $ping_method  = $cacti::ping_method,
  $ping_port    = $cacti::ping_port,
  $ping_retries = $cacti::ping_retries,
  $version      = $cacti::version,
  $port         = $cacti::port,
  $timeout      = $cacti::timeout,
  $community    = $cacti::community,
  $username     = $cacti::username,
  $password     = $cacti::password,
  $authproto    = $cacti::authproto,
  $privpass     = $cacti::privpass,
  $privproto    = $cacti::privproto,
  $cli_dir      = $cacti::cli_dir,
) {

  # The base class must be included first because it is used by parameter defaults
  if ! defined(Class['cacti']) {
    fail('You must include the cacti base class before using any cacti defined resources')
  }

  # fails when no name/title is provided
  if $name == '' {
    fail('Can not create a host with empty title/name')
  }


  # Make a new device and some default graphs
  cacti::device { $name:
    ensure       => $ensure,
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
    privproto    => $privproto,
    cli_dir      => $cli_dir,
  }
  cacti::graph { "Load Average ${name}":
    host          => $name,
    graphtype     => 'cg',
    graphtemplate => 'Unix - Load Average',
    require       =>  Cacti::Device[$name],
  }
  # Some default graphs we use on every device are made here
  ## TO-DO add more default graphs

}
