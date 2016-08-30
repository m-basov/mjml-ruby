require 'tilt/template'
require 'mjml/parser'

# Tilt namespace
module Tilt
  # MJML template for Tilt
  class MJML < Template
    def prepare
    end

    def evaluate(scope, locals, &block)
      @output ||= ::MJML::Parser.new.call(data)
    end
  end

  register MJML, 'mjml' if respond_to?(:register)
end
