require 'spec_helper'

describe 'totpcgi', :type => :class do

  context 'with defaults for all parameters' do
    it 'should fail due to missing configuration hash' do
      expect { should compile }.to \
        raise_error(RSpec::Expectations::ExpectationNotMetError,
          /Must pass configuration/)
    end
  end

  context 'with a configuration hash defined and default parameters' do
    let(:params) {
      {
        'configuration' => {
        }
      }
    }

    it { should contain_class('totpcgi') }
    it { should contain_class('totpcgi::params') }
    it { should contain_anchor('totpcgi::begin') }
    it { should contain_class('totpcgi::install') }
    it { should contain_class('totpcgi::config') }
    it { should contain_class('totpcgi::service') }
    it { should contain_anchor('totpcgi::end') }
  end

  context 'with a configuration hash defined and bad parameters' do
    let(:params) {
      {
        'configuration' => {
        }
      }
    }

    it 'should fail on bad configuration_file' do
      params.merge!({'configuration_file' => 'badvalue'})
      expect { should compile }.to \
        raise_error(RSpec::Expectations::ExpectationNotMetError,
          /"badvalue" is not an absolute path/)
    end

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
end

# vim: sw=2 ts=2 sts=2 et :
