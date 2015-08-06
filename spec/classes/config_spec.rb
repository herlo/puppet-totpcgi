require 'spec_helper'

describe 'totpcgi::config' do
  let(:facts) {
    {
      :fqdn                   => 'test.example.com',
      :hostname               => 'test',
      :ipaddress              => '192.168.0.1',
      :operatingsystem        => 'CentOS',
      :operatingsystemrelease => '7',
      :osfamily               => 'RedHat'
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
    it { should contain_file('/etc/totpcgi').with(
      'ensure'  => 'directory',
      'owner'   => 'totpcgiprov',
      'group'   => 'totpcgi',
      'mode'    => '0750',
    )}

    it { should contain_file('/etc/totpcgi/totpcgi.conf').with(
      'ensure'  => 'file',
      'owner'   => 'totpcgiprov',
      'group'   => 'totpcgi',
      'mode'    => '0640',
    )}

    it { should contain_file('/etc/totpcgi/provisioning.conf').with(
      'ensure'  => 'file',
      'owner'   => 'totpcgiprov',
      'group'   => 'totpcgiprov',
      'mode'    => '0640',
    )}

  end
end

# vim: sw=2 ts=2 sts=2 et :
