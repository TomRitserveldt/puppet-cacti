require 'spec_helper_acceptance'
require 'net/http'
require 'net/https'
require 'pp'

def http_get(url)
   uri = URI.parse(url)
   http = Net::HTTP.new(uri.host, uri.port)
   req = Net::HTTP::Get.new(uri.request_uri)
   # http.verify_mode = OpenSSL::SSL::VERIFY_NONE
   http.request(req)
end

describe 'cacti class' do
  # describe 'running puppet code' do
    hosts_as('server').each do |host|
      it 'applies idempotently' do
        server_pp = <<-EOS
          class { '::cacti':
            server => true,
          }
        EOS
        apply_manifest(server_pp, :catch_failures => true)
        # Run it twice and test for idempotency
        apply_manifest(server_pp, :catch_changes => true)
      end
    end
    hosts_as('client').each do |host|
      it 'should work with no errors on client' do
        # cacti_ip = ipaddresses['debian-78-x64-server']
        client_pp = <<-EOS
          class { '::cacti':
            server => false,
          }
        EOS
        apply_manifest(client_pp, :catch_failures => true)
        # Run it twice and test for idempotency
        apply_manifest(client_pp, :catch_changes => true)
      end
    end
  # end
end

describe 'cacti::server' do
  let(:ipaddresses) do
    hosts_as('server').inject({}) do |memo,host|
      # puts host.name
      # memo[host.name] = fact_on host, "ipaddress_eth1"
      memo[host.name] = host.reachable_name
      memo
    end
  end

  hosts_as('server').each do |host|
    it 'should run puppet cleanly' do
      server_pp = <<-EOS
        class { '::cacti':
          server => true,
        }
      EOS
      apply_manifest(server_pp, :catch_failures => true)
    end
    describe file('/usr/share/cacti/cli/remove_device.php') do
      it { should be_file }
      it { should contain('do NOT run this script through a web browser')}
    end
    describe file('/usr/share/cacti/scripts/cactigraph.sh') do
      it { should be_file }
    end
    describe file('/usr/share/cacti/scripts/cactitree.sh') do
      it { should be_file }
    end
    describe file('/usr/share/cacti/scripts/cactiversion.sh') do
      it { should be_file }
    end
    describe file('/usr/share/cacti/site/include/config.php') do
      it { should be_file }
      its(:content) { should match 'This file is managed by the Cacti puppet module.' }
    end
    describe package('cacti') do
      it { should be_installed }
    end
    describe service('httpd'), :if => os[:family] == 'redhat' do
      it { should be_running }
      it { should be_enabled }
    end
    describe service('apache2'), :if => os[:family] == 'debian' do
      it { should be_enabled }
      it { should be_running }
    end
    describe port(80) do
      it { should be_listening }
    end
    describe 'getting /cacti' do
      it 'should offer us a redirect' do
        response = http_get "http://#{ipaddresses[host.name]}/cacti"
        expect(response.body).to include('301 Moved Permanently')
      end
    end
    describe 'getting /cacti/' do
      it 'should give us a login page' do
        response = http_get "http://#{ipaddresses[host.name]}/cacti/"
        expect(response.body).to include('Please enter your Cacti user name and password below:')
      end
    end
  end
end
