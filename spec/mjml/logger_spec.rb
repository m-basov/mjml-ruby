require_relative '../spec_helper'
require 'mjml/logger'
require 'logger'

describe MJML::Logger do
  let(:logger) { MJML.logger }
  let(:msg) { 'logger msg' }
  let(:matcher) { /msg/ }

  it 'should show errors' do
    capture_subprocess_io { logger.error(msg) }.to_s.must_match matcher
  end

  it 'should show debug messages' do
    logger.level = ::Logger::DEBUG
    capture_subprocess_io { logger.debug(msg) }.to_s.must_match matcher
    logger.level = ::Logger::ERROR
  end
end
