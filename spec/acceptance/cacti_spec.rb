require 'spec_helper_acceptance'

describe 'cacti class' do
  describe 'running puppet code' do
    it 'should work with no errors on server' do
      server_pp = <<-EOS
        class { '::cacti':
          server => true,
        }
      EOS

      on 'server',  apply_manifest(server_pp, :catch_failures => true) do
      # Run it twice and test for idempotency
        expect(apply_manifest(server_pp, :catch_failures => true).exit_code).to be_zero

        # expect(File).to exist('/usr/share/cacti/cli/remove_device.php')

        # File.read("/path/to/file").should match "content"
        # File.read("/path/to/file").should include "content"
      end
    end
    it 'should work with no errors on client' do
      client_pp = <<-EOS
        class { '::cacti':
          server => false,
        }
      EOS

      on 'client',  apply_manifest(client_pp, :catch_failures => true) do
      # Run it twice and test for idempotency
        expect(apply_manifest(client_pp, :catch_failures => true).exit_code).to be_zero
      end
    end
  end
end
