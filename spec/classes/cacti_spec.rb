require 'spec_helper'
describe 'cacti' do

  context 'with defaults for all parameters' do
    let(:facts) { {:osfamily => 'Debian'} }
    it { should contain_class('cacti') }
  end
end
