require 'rails/railtie'
require 'mjml'
require 'mjml/parser'

module MJML
  # Rails plugin for MJML ruby
  class Railtie < ::Rails::Railtie
    # Template handler for Rails
    class Handler
      def initialize(base_handler = :erb)
        @base_handler = base_handler
      end

      def call(template)
        compiled = send("#{@base_handler}_handler").call(template)
        "::MJML::Parser.new.call(begin;#{compiled};end).html_safe"
      end

      private

      def erb_handler
        @erb_handler ||= ActionView::Template.registered_template_handler(:erb)
      end

      def slim_handler
        @slim_handler ||= ActionView::Template.registered_template_handler(:slim)
      end

      def haml_handler
        @haml_handler ||= ActionView::Template.registered_template_handler(:haml)
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
        ActionView::Template.register_template_handler(:mjmlslim, Handler.new(:slim))
        ActionView::Template.register_template_handler(:mjmlhaml, Handler.new(:haml))
      end
    end
  end
end
