require '../spec_helper'
require 'mjml/logger'

describe MJML::Logger do
  let(:logger) { MJML.logger }

  it 'should respond to debug method' do
    logger.respond_to?(:debug).must_equal true
  end
end
