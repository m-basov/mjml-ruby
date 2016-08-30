require_relative '../spec_helper'
require 'sprockets'
require 'sprockets/mjml'

describe Sprockets::MJML do
  let(:raw_template) { Hash[data: read_fixture('hello.mjml')] }

  it 'should render html' do
    result = Sprockets::MJML.call(raw_template)
    result.key?(:data)
    result[:data].wont_be_nil
  end

  it 'should register mjml' do
    # TODO: Find a way to test this
  end
end
