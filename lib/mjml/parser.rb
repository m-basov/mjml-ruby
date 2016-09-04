require 'open3'

module MJML
  # Parser for MJML templates
  class Parser
    class InvalidTemplate < StandardError; end
    class ExecutableNotFound < StandardError; end

    ROOT_TAGS_REGEX = %r{<mjml>.*<\/mjml>}im

    def initialize
      MJML.logger.debug("Path: #{mjml_bin};" \
                        "Version: #{MJML.executable_version}")
      raise ExecutableNotFound if MJML.executable_version.nil?
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
      MJML.logger.debug("Template:\n #{template}")
      raise InvalidTemplate if template.empty?

      MJML.logger.debug("Partial: #{partial?(template)}")
      return template if partial?(template)

      out, err, _sts = Open3.capture3("#{mjml_bin} -is", stdin_data: template)
      MJML.logger.debug("Output:\n #{out};\n\n Errors:\n #{err}")

      raise InvalidTemplate unless err.empty?
      out
    end

    def partial?(template)
      (template =~ ROOT_TAGS_REGEX).nil?
    end

    def mjml_bin
      MJML.config.bin_path
    end
  end
end
