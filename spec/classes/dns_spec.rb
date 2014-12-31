require 'spec_helper'
describe 'profile::dns', :type => :class do
  context 'with defaults for all parameters' do
    it { is_expected.to create_class('profile::dns') }
    it { is_expected.to contain_package('bind') }
    #it { is_expected.to contain_define('bind::server::conf') }
  end
end
