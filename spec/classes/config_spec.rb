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
    let(:params) {
      {
        :totpcgi_config_dir => '/etc/totpcgi',
        :totpcgi_config => '/etc/totpcgi/totpcgi.conf',
        :totpcgi_group      => 'totpcgi',
        :totpcgi_owner      => 'totpcgi',
        :provisioning_config  => '/etc/totpcgi/provisioning.conf',
        :provisioning_owner   => 'totpcgiprov',
        :provisioning_group   => 'totpcgiprov',
        :pincode_engine => 'file',
        :pincode_file   => '/etc/totpcgi/totpcgi.conf',
        :secret_engine  => 'file',
        :secrets_dir    => '/etc/totpcgi/totp',
        :state_engine   => 'file',
        :state_dir      => '/var/lib/totpcgi',
        :broken_selinux_python_policy   => 'true',
      }
    }

    it do
      expect {
        should compile
      }.to raise_error(RSpec::Expectations::ExpectationNotMetError,
        /Must pass /)
    end

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
