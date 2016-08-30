require 'dry-configurable'

# MJML library for ruby
module MJML
  extend Dry::Configurable

  # Available settings
  setting :bin_path

  def self.setup!
    # Init config
    configure do |config|
      config.bin_path = find_executable
    end
  end

  def self.find_executable
    local_path = File.expand_path('node_modules/.bin/mjml', Dir.pwd)
    return local_path if File.file?(local_path)
    `which mjml`.strip
  end
end

require 'tilt/mjml' if defined?(Tilt)
