require 'sprockets'
require 'mjml'

# Sprockets
module Sprockets
  # MJML interface for Sprockets
  class MJML
    def self.call(input)
      input.merge(data: ::MJML::Parser.new.call(input[:data]))
    end
  end

  if respond_to?(:register_transformer)
    register_mime_type ::MJML::MIME_TYPE, extensions: [::MJML::EXTENSION],
                                          charset: :unicode
    register_transformer ::MJML::MIME_TYPE, 'text/html', MJML
  end

  if respond_to?(:register_engine)
    args = [::MJML::EXTENSION, MJML]
    if Sprockets::VERSION.start_with?('3')
      args << { mime_type: ::MJML::MIME_TYPE, silence_deprecation: true }
    end
    register_engine(*args)
  end
end
