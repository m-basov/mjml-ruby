module MJML
  module Rails
    # MJML Template handler for Rails
    class TemplateHandler
      # Supported extensions
      EXTENSIONS = Hash[erb: :mjml, slim: :mjmlslim, haml: :mjmlhaml]

      def initialize(base_handler = :erb)
        @base_handler = base_handler
      end

      def call(template)
        compiled = get_handler(@base_handler).call(template)
        "::MJML::Parser.new.call!(begin;#{compiled};end).html_safe"
      end

      private

      def get_handler(ext)
        handler = instance_variable_get("@#{ext}_handler")
        if handler.nil?
          handler = ActionView::Template.registered_template_handler(ext)
          instance_variable_set("@#{ext}_handler", handler)
        end
        handler
      end
    end
  end
end
