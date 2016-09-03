require 'rails/railtie'
require 'mjml'
require 'mjml/parser'

module MJML
  # Rails plugin for MJML ruby
  class Railtie < ::Rails::Railtie
    # Template handler for Rails
    class Handler
      def call(template)
        compiled = erb_handler.call(template)
        "::MJML::Parser.new.call(begin;#{compiled};end).html_safe"
      end

      private

      def erb_handler
        @erb_handler ||= ActionView::Template.registered_template_handler(:erb)
      end
    end

    # Config
    config.mjml = MJML.config

    # Initializers
    initializer 'mjml.register_extension' do
      unless Mime::Type.lookup ::MJML::MIME_TYPE
        Mime::Type.register ::MJML::MIME_TYPE, :mjml
      end

      ActiveSupport.on_load(:action_view) do
        ActionView::Template.register_template_handler(:mjml, Handler.new)
      end

      config.mjml.logger = Rails.logger
    end
  end
end
