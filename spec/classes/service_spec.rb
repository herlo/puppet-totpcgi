require 'spec_helper'

describe 'totpcgi::service' do
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
    let (:params) {{}}

    it do
      expect {
        should compile
      }.to raise_error(RSpec::Expectations::ExpectationNotMetError,
        /Must pass /)
    end
  end

  context 'with basic config defaults' do
    let(:params) {
      {
        :vhost_name => 'test.example.com',
        :port       => 8140,
        :servername => 'test.example.com',
        :docroot    => '/var/www/totpcgi',
        :suexec_user_group => 'totpcgi totpcgi',
        :ssl_cacert => '/etc/ipa/ca.crt',
        :ssl_cert   => '/etc/pki/puppet/certs/test.example.com.pem',
        :ssl_key    => '/etc/pki/puppet/private/test.example.com.pem',
        :ssl_verify_client => 'require',
        :ssl_verify_depth => 10,
        :totpcgi_owner => 'totpcgi',
        :totpcgi_group => 'totpcgi',
      }
    }

    it { should contain_file('/var/www/totpcgi').with(
      'ensure'  => 'directory',
      'owner'   => 'totpcgi',
      'group'   => 'totpcgi',
      'mode'    => '0751',
    )}

    it { should contain_file('/var/www/totpcgi/index.cgi').with(
      'ensure'  => 'file',
      'owner'   => 'totpcgi',
      'group'   => 'totpcgi',
      'mode'    => '0550',
    )}

  end
end

#  vim: set ts=2 sw=2 tw=0 et :
