require 'open3'

module MJML
  # Parser for MJML templates
  class Parser
    class InvalidTemplate < StandardError; end
    class ExecutableNotFound < StandardError; end

    ROOT_TAGS_REGEX = %r{<mjml>.*<\/mjml>}im

    def initialize
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
      raise InvalidTemplate if template.empty?
      return template if partial?(template)

      out, err, _status = Open3.capture3(build_cmd(template))

      raise InvalidTemplate unless err.empty?
      out
    end

    def partial?(template)
      (template =~ ROOT_TAGS_REGEX).nil?
    end

    def mjml_bin
      MJML.config.bin_path
    end

    def build_cmd(template)
      "/usr/bin/env bash -c \"echo '#{template}' | #{mjml_bin} -is\""
    end
  end
end
