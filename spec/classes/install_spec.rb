require 'spec_helper'

describe 'totpcgi::install', :type => :class do
  # set some default good params so we can override with bad ones in
  # test
    let(:facts) {
    {
      :fqdn            => 'test.example.com',
      :hostname        => 'test',
      :ipaddress       => '192.168.0.1',
      :operatingsystem => 'CentOS',
      :osfamily        => 'RedHat'
    }
  }

  # we do not have default values so the class should fail compile
  context 'with defaults for all parameters' do
    let(:params) {{}}

    it do
      expect {
        should compile
      }.to raise_error(RSpec::Expectations::ExpectationNotMetError,
        /Must pass /)
    end
  end

   context 'with basic init defaults' do
         let(:params) {
      {
        'install_totpcgi' => true
      }
    }
    it { should contain_class('totpcgi::install') }
    it { should contain_package('totpcgi') }
    it { should contain_package('totpcgi-selinux') }
    it { should contain_package('totpcgi-provisioning') }
   end
end

# vim: sw=2 ts=2 sts=2 et :

