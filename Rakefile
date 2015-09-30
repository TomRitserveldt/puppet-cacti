# Rakefile
require 'rubygems'
require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-lint'
require 'puppet-syntax/tasks/puppet-syntax'

exclude_paths = [
  "environments/**/*",
  "modules/upstream/**/*",
  "modules/vrt/**/*",
]

PuppetSyntax.exclude_paths = exclude_paths
# PuppetLint.configuration.log_format = "%{path}:%{linenumber}:%{check}:%{KIND}:%{message}"
# PuppetLint.configuration.send("disable_80chars")
# PuppetLint.configuration.send("disable_autoloader_layout")
# PuppetLint.configuration.send("disable_quoted_booleans")
# PuppetLint.configuration.ignore_paths = exclude_paths

# workaround for https://github.com/rodjek/puppet-lint/issues/355
Rake::Task[:lint].clear
PuppetLint::RakeTask.new :lint do |config|
  config.fail_on_warnings = true
  config.disable_checks = [
    '80chars',
    'class_inherits_from_params_class',
  ]
  config.ignore_paths = [
    "environments/**/*",
    "modules/upstream/**/*",
    "modules/vrt/**/*",
  ]
end
