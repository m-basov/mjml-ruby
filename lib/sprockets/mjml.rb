require 'sprockets'
require 'mjml/parser'

# Sprockets
module Sprockets
  # MJML interface for Sprockets
  class MJML
    def self.call(input)
      input.merge(data: ::MJML::Parser.new.call(input[:data]))
    end
  end

  if respond_to?(:register_transformer)
    register_mime_type 'text/mjml', extensions: ['.mjml'], charset: :unicode
    register_transformer 'text/mjml', 'text/html', MJML
  end

  if respond_to?(:register_engine)
    args = ['.mjml', MJML]
    if Sprockets::VERSION.start_with?('3')
      args << { mime_type: 'text/mjml', silence_depreaction: true }
    end
    register_engine(*args)
  end
end
