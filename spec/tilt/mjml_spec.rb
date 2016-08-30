require_relative '../spec_helper'
require 'tilt'
require 'tilt/mjml'

describe Tilt::MJML do
  let(:template_path) { "#{FIXTURES_PATH}/hello.mjml" }

  it 'should return html' do
    template = Tilt::MJML.new(template_path)
    template.render.wont_be_nil
  end

  it 'should register mjml' do
    Tilt.new(template_path).wont_be_nil
  end
end
