source 'https://rubygems.org'

puppetversion = ENV.key?('PUPPET_VERSION') ? "#{ENV['PUPPET_VERSION']}" : ['>= 3.3']

group :development, :test do
  gem 'beaker-rspec',                       :require => false
  gem 'puppet', puppetversion,              :require => false
  gem 'puppetlabs_spec_helper', '>= 0.8.2', :require => false
  gem 'puppet-lint', '>= 1.0.0',            :require => false
  gem 'facter', '>= 1.7.0',                 :require => false
end
