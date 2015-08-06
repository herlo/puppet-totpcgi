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
    it { should contain_class('totpcgi') }
    it { should contain_class('totpcgi::params') }
    it { should contain_anchor('totpcgi::begin') }
    it { should contain_class('totpcgi::install') }
    it { should contain_class('totpcgi::config') }
    it { should contain_class('totpcgi::service') }
    it { should contain_anchor('totpcgi::end') }
  end
end

# vim: sw=2 ts=2 sts=2 et :
