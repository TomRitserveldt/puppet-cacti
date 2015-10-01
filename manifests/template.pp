# == Definition: cacti::template
#
define cacti::template (
  $cli_dir       = $cacti::cli_dir,
  $cacti_dir     = $cacti::cacti_dir,
  $filename      = $cacti::filename,
) {

  if ! defined(Class['cacti']) {
    fail('You must include the cacti base class before using any cacti defined resources')
  }

  exec { "cacti::template::import_template_${name}":
    command => template('cacti/import_template.erb'),
    require => File["${cacti_dir}/scripts/${filename}"],
  }
}

