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
  $cli_dir
) {

case $ensure {
  'present': {
     exec { "cacti::device::add_device_${description}":
       command => "/usr/bin/php -q ${cli_dir}/add_device.php --list-host-templates | grep '${template}' | awk '{print \$1}' | xargs -I++ php -q ${cli_dir}/add_device.php --description='${description}' --ip=${ip} --template=++ --notes='${notes}' --disable=${disable} --avail=${avail} --ping_method=${ping_method} --ping_port=${ping_port} --ping_retries=${ping_retries} --version=${version} --port=${port} --timeout=${timeout} --community=${community} --username='${username}' --password='${password}' --authproto='${authproto}' --privpass='${privpass}' --privproto='${privproto}'",
       unless  => "/usr/bin/php -q ${cli_dir}/add_graphs.php --list-hosts | grep ${description}",
     }
  }
  'absent': {
     exec { "cacti::device::remove_device_${description}":
       command => "/usr/bin/php -q ${cli_dir}/remove_device.php --list-devices | grep '${description}' | awk '{print \$1}' | xargs -I++ php -q ${cli_dir}/remove_device.php --device_id=++ ",
     }
  }
}
}
