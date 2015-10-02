# == Definition: cacti::device
#
define cacti::device (
  $ip          ,
  $ensure      ,
  $disable     ,
  $description ,
  $template    ,
  $notes       ,
  $disable     ,
  $avail       ,
  $ping_method ,
  $ping_port   ,
  $ping_retries,
  $version     ,
  $port        ,
  $timeout     ,
  $community   ,
  $username    ,
  $password    ,
  $authproto   ,
  $privpass    ,
  $privproto   ,
  $cli_dir     ,
  $node_type   ,
  $tree_id     ,
  $parent_node ,
  $host_group_s,
  $host_id     ,
) {

  case $ensure {
  'present': {
    exec { "cacti::device::add_device_${description}":
      command => template('cacti/add_device.erb'),
      unless  => template('cacti/check_device.erb'),
    }
    exec { "cacti::device::assign_tree_${description}":
      command => template('cacti/assign_tree.erb'),
    }
  }
  'absent': {
    exec { "cacti::device::remove_device_${description}":
    command => template('cacti/remove_device.erb'),
    }
  }
  default: {
    exec { "cacti::device::add_device_${description}":
      command => template('cacti/add_device.erb'),
      unless  => template('cacti/check_device.erb'),
    }
  }
  }
}
