require 'bundler/setup'
require 'minitest/autorun'

FIXTURES_PATH = File.expand_path('spec/fixtures', Dir.pwd)

def read_fixture(name)
  File.open("#{FIXTURES_PATH}/#{name}", 'rb', &:read)
end
