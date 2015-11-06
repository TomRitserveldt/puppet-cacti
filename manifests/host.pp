# == Definition: cacti::host
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
  $tree_id      = $cacti::tree_id,
  $node_type    = $cacti::node_type,
  $parent_node  = $cacti::parent_node,
  $host_group_s = $cacti::host_group_s,
  $install_dir    = $cacti::install_dir,
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
    tree_id      => $tree_id,
    node_type    => $node_type,
    parent_node  => $parent_node,
    host_group_s => $host_group_s,
    install_dir    => $install_dir,
  }
  cacti::graph { 'Load Average cacti-master':
    host          => $name,
    graphtype     => 'cg',
    graphtemplate => 'Unix - Load Average',
    require       =>  Cacti::Device[$name],
  }
  # Some default graphs we use on every device are made here
  ## TO-DO add more default graphs

}
