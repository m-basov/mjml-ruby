require 'rails/railtie'
require 'mjml'
require 'mjml/parser'
require 'mjml/rails/template_handler'

module MJML
  # Rails plugin for MJML ruby
  class Railtie < ::Rails::Railtie
    # Config
    config.mjml = MJML.config

    # Initializers
    initializer 'mjml.register_extension' do
      unless Mime::Type.lookup ::MJML::MIME_TYPE
        Mime::Type.register ::MJML::MIME_TYPE, :mjml
      end

      ActiveSupport.on_load(:action_view) do
        MJML::Rails::TemplateHandler::EXTENSIONS.each do |h, ext|
          ActionView::Template.register_template_handler(ext, MJML::Rails::TemplateHandler.new(h))
        end
      end
    end
  end
end
