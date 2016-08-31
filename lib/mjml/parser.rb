require 'open3'

module MJML
  # Parser for MJML templates
  class Parser
    class InvalidTemplate < StandardError; end
    class ExecutableNotFound < StandardError; end

    ROOT_TAGS_REGEX = %r{<mjml>.*<\/mjml>}im
    VERSION_REGEX = /^\d\.\d\.\d/i

    def initialize
      raise ExecutableNotFound if mjml_version.nil?
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
      raise InvalidTemplate if template.empty?
      return template if partial?(template)

      out, err, _status = Open3.capture3("#{mjml_bin} -is <<< '#{template}'")

      raise InvalidTemplate unless err.empty?
      out
    end

    def partial?(template)
      (template =~ ROOT_TAGS_REGEX).nil?
    end

    def mjml_bin
      MJML.config.bin_path
    end

    def mjml_version
      ver = `#{mjml_bin} -V`.strip
      (ver =~ VERSION_REGEX).nil? ? nil : ver
    end
  end
end
