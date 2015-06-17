require 'spec_helper'

describe 'totpcgi::config', :type => :class do
  # set some default good params so we can override with bad ones in
  # test
  let(:params) {
    {
      'configuration'      => {
        'key0' => 'value',
        'key1' => ['value0', 'value1'],
      },
      'configuration_file' => '/configfile.yaml',
      'group'              => 'group',
      'user'               => 'user'
    }
  }

  # we do not have default values so the class should fail compile
  context 'with defaults for all paremeters' do
    let(:params) {{}}

    it do
      expect {
        should compile
      }.to raise_error(RSpec::Expectations::ExpectationNotMetError,
        /Must pass configuration/)
    end
  end

  context 'with bad parameters' do
    it 'should fail on bad configuration' do
      params.merge!({'configuration' => 'badvalue'})
      expect { should compile }.to \
        raise_error(RSpec::Expectations::ExpectationNotMetError,
          /"badvalue" is not a Hash/)
    end

    it 'should fail on bad configuration_file' do
      params.merge!({'configuration_file' => 'badvalue'})
      expect { should compile }.to \
        raise_error(RSpec::Expectations::ExpectationNotMetError,
          /"badvalue" is not an absolute path/)
    end

    it 'should fail on a bad group' do
      params.merge!({'group' => false})
      expect { should compile }.to \
        raise_error(RSpec::Expectations::ExpectationNotMetError,
          /false is not a string/)
    end

    it 'should fail on a bad user' do
      params.merge!({'user' => false})
      expect { should compile }.to \
        raise_error(RSpec::Expectations::ExpectationNotMetError,
          /false is not a string/)
    end
  end

  context 'with good parameters' do
    it { is_expected.to contain_file(
      '/configfile.yaml').with(
        'ensure'  => 'file',
        'mode'    => '0644',
        'owner'   => 'user',
        'group'   => 'group',
        'content' => "---\nkey0: value\nkey1:\n- value0\n- value1\n",
    ) }
  end

end

# vim: sw=2 ts=2 sts=2 et :
