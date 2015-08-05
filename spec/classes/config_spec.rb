require 'spec_helper'

describe 'totpcgi::config', :type => :class do
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
        /Must pass configuration/)
    end

    it { should contain_file("$totpcgi_config_dir").with(
      'ensure'  => 'directory',
      'owner'   => 'totpcgiprov',
      'group'   => 'totpcgi',
      'mode'    => '0750',
    )}

    it { should contain_file( "$totpcgi_config").with(
      'ensure'  => 'file',
      'owner'   => 'totpcgiprov',
      'group'   => 'totpcgi',
      'mode'    => '0640',
    )}

    it { should contain_file("$provisioning_config").with(
      'ensure  => 'file',
      'owner   => 'totpcgiprov',
      'group'   => 'totpcgiprov',
      'mode'    => '0640',
    )}

  end
end

# vim: sw=2 ts=2 sts=2 et :
