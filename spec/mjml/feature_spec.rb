require_relative '../spec_helper'
require 'mjml/feature'

describe MJML::Feature do
  let(:mjml_version) { MJML.executable_version }
  let(:level_availability) { MJML.executable_version.start_with?('3') }

  describe '#availalbe?' do
    it 'should return true for :validation_level if mjml is >v3' do
      MJML::Feature.available?(:validation_level).must_equal level_availability
    end

    it 'should return false for unknown feature' do
      MJML::Feature.available?(:spaceship).must_equal false
    end
  end

  describe '#missing?' do
    it 'should return false for availalbe feature' do
      MJML::Feature.missing?(:validation_level).must_equal !level_availability
    end

    it 'should return true for unknown feature' do
      MJML::Feature.missing?(:spaceship).must_equal true
    end
  end
end
