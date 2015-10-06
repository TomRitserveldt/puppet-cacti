# == Definition: cacti::template
#
#  This class lets you import cacti templates from an xml file.
#  First make sure the file is located on the server in the ${cacti_dir}/scripts/ directory.
#  assigning the filename param is mandatory.
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

