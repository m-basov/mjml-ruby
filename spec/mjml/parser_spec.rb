require_relative '../spec_helper'
require 'mjml/parser'

describe MJML::Parser do
  let(:parser) { MJML::Parser.new }
  let(:raw_template) { read_fixture('hello.mjml') }
  let(:compiled_template) { read_fixture('hello.html') }
  let(:minified_template) { read_fixture('hello.min.html') }

  describe 'valid template' do
    it 'should return correct output' do
      parser.call(raw_template).must_equal compiled_template
    end
  end

  describe 'invalid template' do
    it 'should raise exception' do
      -> { parser.call!('') }.must_raise MJML::Parser::InvalidTemplate
    end

    it 'should return nil' do
      parser.call('').must_be_nil
    end
  end

  describe 'partial' do
    let(:partial) { read_fixture('partial.mjml') }

    it 'should return raw partial' do
      parser.call(partial).must_equal partial
    end
  end

  describe 'minified output' do
    it 'should return not minified outup' do
      MJML.configure { |c| c.minify_output = false }
      parser.call(raw_template).must_equal compiled_template
    end

    it 'should return minified output' do
      MJML.configure { |c| c.minify_output = true }
      parser.call(raw_template).must_equal minified_template
    end
  end
end
