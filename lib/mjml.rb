require 'dry-configurable'

# MJML library for ruby
module MJML
  # Constants
  MIME_TYPE = 'text/mjml'.freeze
  EXTENSION = '.mjml'.freeze
  VERSION_REGEX = /^\d\.\d\.\d/i

  extend Dry::Configurable
  # Available settings
  setting :bin_path
  setting :debug
  setting :logger

  def self.setup!
    # Init config
    configure do |config|
      config.bin_path = find_executable
      config.logger = choose_logger
      config.debug = false
    end
  end

  def self.find_executable
    local_path = File.expand_path('node_modules/.bin/mjml', Dir.pwd)
    return local_path if File.file?(local_path)
    `/usr/bin/env bash -c "which mjml"`.strip
  end

  def self.executable_version
    ver, _status = Open3.capture2(find_executable, '-V')
    (ver =~ VERSION_REGEX).nil? ? nil : ver
  end

  def self.choose_logger
    if defined?(Rails)
      Rails.logger
    else
      require 'mjml/logger'
      MJML::Logger.setup!(STDOUT)
    end
  end

  def self.logger
    config.logger
  end
end

MJML.setup!

require 'mjml/parser'
require 'tilt/mjml' if defined?(Tilt)
require 'sprockets/mjml' if defined?(Sprockets)
require 'mjml/railtie' if defined?(Rails)
