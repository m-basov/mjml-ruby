require 'mjml/logger'
require 'mjml/feature'
require 'mjml/parser'

# MJML library for ruby
module MJML
  class BinaryNotFound < StandardError; end

  # Constants
  MIME_TYPE = 'text/mjml'.freeze
  EXTENSION = '.mjml'.freeze
  VERSION_3_REGEX = /^(\d\.\d\.\d)/i
  VERSION_4_REGEX = /^mjml-cli: (\d\.\d\.\d)/i

  # Available settings
  module Config
    class << self
      attr_accessor(
        :bin_path,
        :debug,
        :logger,
        :minify_output,
        :validation_level
      )
    end
  end

  def self.setup!
    # Init config
    Config.bin_path = find_executable
    Config.debug = nil
    Config.logger = Logger.setup!(STDOUT)
    Config.minify_output = false
    Config.validation_level = :skip
  end

  def self.find_executable
    local_path = File.expand_path('node_modules/.bin/mjml', Dir.pwd)
    return local_path if File.file?(local_path)
    `/usr/bin/env which mjml`.strip
  end

  def self.executable_version
    @executable_version ||= extract_executable_version
  end

  def self.extract_executable_version
    ver, _status = Open3.capture2(Config.bin_path, '--version')

    # mjml 3.x outputs version directly:
    #   3.3.5
    # --> just take this as the version

    # mjml 4.x outputs two rows:
    #   mjml-core: 4.0.0
    #   mjml-cli: 4.0.0
    # --> we take the second number as the version, since we call the cli

    case ver.count("\n")
    when 1
      # one line, mjml 3.x
      match = ver.match(VERSION_3_REGEX)
    when 2
      # two lines, might be 4.x
      match = ver.match(VERSION_4_REGEX)
    end

    match.nil? ? nil : match[1]
  rescue Errno::ENOENT => _e
    raise BinaryNotFound, "mjml binary not found for path '#{Config.bin_path}'"
  end

  def self.logger
    Config.logger
  end
end

MJML.setup!

require 'tilt/mjml' if defined?(Tilt)
require 'sprockets/mjml' if defined?(Sprockets)
require 'mjml/railtie' if defined?(Rails)
