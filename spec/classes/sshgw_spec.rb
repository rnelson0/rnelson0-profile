require 'spec_helper'
describe 'profile::sshgw', :type => :class do
  context 'with defaults for all parameters' do
    it { is_expected.to create_class('profile::sshgw') }
    it { is_expected.to contain_package('sshvpn') }
  end
end
