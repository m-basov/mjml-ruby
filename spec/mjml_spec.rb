require_relative 'spec_helper'
require 'mjml'

describe 'MJML' do
  describe '#extract_executable_version' do
    it 'should return the version if mjml is installed' do
      MJML.extract_executable_version.must_be_instance_of String
    end

    it 'should return false for unknown feature' do
      bin_path = MJML::Config.bin_path
      MJML::Config.bin_path = '/usr/bin/env mjml-not-installed'

      error = -> { MJML.extract_executable_version }.must_raise MJML::BinaryNotFound
      error.message.must_match(/^mjml binary not found/)

      MJML::Config.bin_path = bin_path
    end

    it 'should work with multi-digit versions' do
      version = '3.10.235'.match(MJML::VERSION_3_REGEX)
      _(version[1]).must_equal('3.10.235')

      version = "mjml-core: 4.10.235\nmjml-cli: 4.10.235".match(MJML::VERSION_4_REGEX)
      _(version[1]).must_equal('4.10.235')
    end
  end
end
