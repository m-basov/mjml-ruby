require 'logger'

module MJML
  # Simple logger for debugging MJML
  class Logger < ::Logger
    def self.setup!(destination)
      logger = new(destination)
      logger.level = ::Logger::ERROR

      logger.formatter = proc do |severity, datetime, _progname, msg|
        "[#{datetime}] #{severity} -- MJML: #{msg}\n\n"
      end

      logger
    end
  end
end
