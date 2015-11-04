source 'https://rubygems.org'

puppetversion = ENV.key?('PUPPET_VERSION') ? "#{ENV['PUPPET_VERSION']}" : ['>= 3.3']

group :development, :test do
  gem 'pry',                                                        :require => false
  gem 'beaker-rspec',                                               :require => false
  gem 'puppet', puppetversion,                                      :require => false
  gem 'puppetlabs_spec_helper', '>= 0.8.2',                         :require => false
  gem 'puppet-lint', '>= 1.0.0',                                    :require => false
  gem 'facter', '>= 1.7.0',                                         :require => false
  gem 'metadata-json-lint',                                         :require => false
  gem 'puppet-lint-appends-check',                                  :require => false
  gem 'puppet-lint-absolute_classname-check',                       :require => false
  gem 'puppet-lint-absolute_template_path',                         :require => false
  gem 'puppet-lint-classes_and_types_beginning_with_digits-check',  :require => false
  gem 'puppet-lint-empty_string-check',                             :require => false
  gem 'puppet-lint-file_ensure-check',                              :require => false
  gem 'puppet-lint-file_source_rights-check',                       :require => false
  gem 'puppet-lint-leading_zero-check',                             :require => false
  gem 'puppet-lint-numericvariable',                                :require => false
  gem 'puppet-lint-param-docs',                                     :require => false
  gem 'puppet-lint-resource_outside_class-check',                   :require => false
  gem 'puppet-lint-spaceship_operator_without_tag-check',           :require => false
  gem 'puppet-lint-trailing_comma-check',                           :require => false
  gem 'puppet-lint-trailing_newline-check',                         :require => false
  gem 'puppet-lint-undef_in_function-check',                        :require => false
  gem 'puppet-lint-unquoted_string-check',                          :require => false
  gem 'puppet-lint-variable_contains_upcase',                       :require => false
  gem 'puppet-lint-version_comparison-check',                       :require => false
  gem 'puppet-lint-strict_indent-check',                            :require => false
end
