require 'bundler/setup'
require 'minitest/autorun'
require 'mjml'

FIXTURES_PATH = File.expand_path('spec/fixtures', Dir.pwd)

def read_fixture(name)
  File.open("#{FIXTURES_PATH}/#{name}", 'rb', &:read)
end

puts "MJML executable path: #{MJML.find_executable}"
puts "MJML executable version: #{MJML.executable_version}"
