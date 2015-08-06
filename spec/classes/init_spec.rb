require 'spec_helper'
describe 'totpcgi', :type => :class do
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

  context 'with defaults for all parameters' do
    let(:params) {
      {
        :servername => 'test.example.com',
        :docroot    => '/var/www/totpcgi',
        :suexec_user_group => 'totpcgi totpcgi',
        :ssl_cacert => '/etc/ipa/ca.crt',
        :ssl_cert   => '/etc/pki/puppet/certs/test.example.com.pem',
        :ssl_key    => '/etc/pki/puppet/private/test.example.com.pem',
        :ssl_verify_client => 'require',
        :ssl_verify_depth => '10',
        :users => {
          'totpcgi' => {
            'ensure' => 'present',
            'managehome' => 'false',
            'home' => '/var/lib/totpcgi',
            'shell' => '/sbin/nologin'
          },
          'totpcgiprov' => {
            'ensure' => 'present',
            'managehome' => 'false',
            'home' => '/etc/totpcgi',
            'shell' => '/sbin/nologin'
          }
        }
      }
    }
    it { should contain_class('totpcgi') }
    it { should contain_anchor('totpcgi::begin') }
    it { should contain_class('totpcgi::install') }
    it { should contain_class('totpcgi::config') }
    it { should contain_class('totpcgi::service') }
    it { should contain_anchor('totpcgi::end') }
  end
end

# vim: sw=2 ts=2 sts=2 et :
