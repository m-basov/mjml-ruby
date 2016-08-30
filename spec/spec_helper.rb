require 'bundler/setup'
require 'minitest/autorun'
require 'mjml'

FIXTURES_PATH = File.expand_path('spec/fixtures', Dir.pwd)

def read_fixture(name)
  File.open("#{FIXTURES_PATH}/#{name}", 'rb', &:read)
end

MJML.setup!
