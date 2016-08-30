require 'open3'

module MJML
  # Parser for MJML templates
  class Parser
    class InvalidTemplate < StandardError; end

    def initialize
    end

    def call(template)
      exec!(template)
    rescue InvalidTemplate
      nil
    end

    def call!(template)
      exec!(template)
    end

    private

    def exec!(template)
      out, err, _status = Open3.capture3("#{mjml_bin} -is <<< '#{template}'")
      raise InvalidTemplate unless err.empty?
      out
    end

    def mjml_bin
      MJML.config.bin_path
    end
  end
end
