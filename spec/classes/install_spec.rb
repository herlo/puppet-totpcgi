require 'spec_helper'

describe 'totpcgi::install', :type => :class do
  # set some default good params so we can override with bad ones in
  # test
  let(:params) {
    {
      'group'      => 'totpcgi',
      'user'       => 'totpcgi',
      'user_home'  => '/home/totpcgi',
      'venv_path'  => '/opt/venv-totpcgi',
      'vcs_path'   => '/opt/vcs-totpcgi',
      'vcs_source' => 'https://github.com/openstack-infra/totpcgi.git',
      'vcs_type'   => 'git',
    }
  }

  # we do not have default values so the class should fail compile
  context 'with defaults for all parameters' do
    let(:params) {{}}

    it do
      expect {
        should compile
      }.to raise_error(RSpec::Expectations::ExpectationNotMetError,
        /Must pass group/)
    end
  end

  context 'with bad parameters' do
    it 'should fail on bad group' do
      params.merge!({'group' => false})
      expect { should compile }.to \
        raise_error(RSpec::Expectations::ExpectationNotMetError,
          /false is not a string/)
    end

    it 'should fail on bad user' do
      params.merge!({'user' => false})
      expect { should compile }.to \
        raise_error(RSpec::Expectations::ExpectationNotMetError,
          /false is not a string/)
    end

    it 'should fail on bad user_home' do
      params.merge!({'user_home' => 'badvalue'})
      expect { should compile }.to \
        raise_error(RSpec::Expectations::ExpectationNotMetError,
          /"badvalue" is not an absolute path/)
    end

    it 'should fail on bad venv_path' do
      params.merge!({'venv_path' => 'badvalue'})
      expect { should compile }.to \
        raise_error(RSpec::Expectations::ExpectationNotMetError,
          /"badvalue" is not an absolute path/)
    end

    it 'should fail on bad vcs_path' do
      params.merge!({'vcs_path' => 'badvalue'})
      expect { should compile }.to \
        raise_error(RSpec::Expectations::ExpectationNotMetError,
          /"badvalue" is not an absolute path/)
    end

    it 'should fail on bad vcs_source' do
      params.merge!({'vcs_source' => false})
      expect { should compile }.to \
        raise_error(RSpec::Expectations::ExpectationNotMetError,
          /false is not a string/)
    end

    it 'should fail on bad vcs_type' do
      params.merge!({'vcs_type' => false})
      expect { should compile }.to \
        raise_error(RSpec::Expectations::ExpectationNotMetError,
          /false is not a string/)
    end

    it 'should fail on bad vcs_revision' do
      params.merge!({'vcs_revision' => true})
      expect { should compile }.to \
        raise_error(RSpec::Expectations::ExpectationNotMetError,
          /true is not a string/)
    end
  end

  # actual validation tests for what the class should produce
  context 'with good parameters' do
    it { should contain_vcsrepo('/opt/vcs-totpcgi').with(
      'ensure'   => 'present',
      'provider' => 'git',
      'source'   => 'https://github.com/openstack-infra/totpcgi.git',
    ) }

    it { should contain_exec('install totpcgi into /opt/venv-totpcgi').with(
      'command'     => 'source /opt/venv-totpcgi/bin/activate; pip install .',
      'cwd'         => '/opt/vcs-totpcgi',
      'provider'    => 'shell',
      'refreshonly' => true,
      'path'        => ['/usr/bin', '/usr/sbin'],
    ) }

    it { should contain_group('totpcgi') }

    it { should contain_user('totpcgi').with(
      'ensure'     => 'present',
      'home'       => '/home/totpcgi',
      'shell'      => '/bin/bash',
      'gid'        => 'totpcgi',
      'managehome' => true,
    ) }

    it { should contain_file('/etc/totpcgi').with(
      'ensure' => 'directory',
      'owner'  => 'totpcgi',
      'group'  => 'totpcgi',
      'mode'   => '0740',
    ) }
  end
end

# vim: sw=2 ts=2 sts=2 et :

