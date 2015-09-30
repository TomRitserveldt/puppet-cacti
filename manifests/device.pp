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
) {

case $ensure {
  'present': {
     exec { "cacti::device::add_device_${description}":
       command => template('cacti/add_device.erb'),
       unless  => template('cacti/check_device.erb'),
     }
  }
  'absent': {
     exec { "cacti::device::remove_device_${description}":
       command => template('cacti/remove_device.erb'),
     }
  }
}
}
