require 'spec_helper'

describe 'totpcgi::params', :type => :class do
  context 'with defaults' do
    it { is_expected.to contain_class('totpcgi::params') }
  end
end

# vim: sw=2 ts=2 sts=2 et :
