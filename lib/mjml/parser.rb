require 'open3'

module MJML
  # Parser for MJML templates
  class Parser
    class InvalidTemplate < StandardError; end
    class ExecutableNotFound < StandardError; end

    ROOT_TAGS_REGEX = %r{<mjml.*>.*<\/mjml>}im

    def initialize
      MJML.logger.debug("Path: #{mjml_bin};" \
                        "Version: #{MJML.executable_version}")
      raise ExecutableNotFound if MJML.executable_version.nil?
    end

    def call(template)
      @template = template
      exec!
    rescue InvalidTemplate
      nil
    end

    def call!(template)
      @template = template
      exec!
    end

    private

    def exec!
      MJML.logger.debug("Template:\n #{@template}")
      raise InvalidTemplate if @template.empty?

      MJML.logger.debug("Partial: #{partial?}")
      return @template if partial?

      out, err = should_get_outpout_from_file? ? output_from_file : output_from_memory
      parsed = parse_output(out)

      MJML.logger.debug("Output:\n #{parsed[:output]}")
      MJML.logger.error(err) unless err.empty?
      MJML.logger.warn(parsed[:warnings]) unless parsed[:warnings].empty?

      raise InvalidTemplate unless err.empty?
      parsed[:output]
    end

    def partial?
      (@template =~ ROOT_TAGS_REGEX).nil?
    end

    def mjml_bin
      MJML.config.bin_path
    end

    def cmd(file_path = nil)
      "#{mjml_bin} #{minify_output} #{validation_level} #{cmd_options}"
    end

    def cmd_options
      if should_get_outpout_from_file?
        "-i -o #{@temp_file.path}"
      else
        "-is"
      end
    end

    def minify_output
      '--min' if MJML.config.minify_output
    end

    def validation_level
      "--level=#{MJML.config.validation_level}" if MJML::Feature.available?(:validation_level)
    end

    def output_from_file
      @temp_file = Tempfile.new("mjml-template")
      _out, err, _sts = Open3.capture3(cmd, stdin_data: @template)
      @temp_file.rewind
      @temp_file.unlink
      return @temp_file.read, err
    end

    def output_from_memory
      out, err, _sts = Open3.capture3(cmd, stdin_data: @template)
      return out, err
    end

    def should_get_outpout_from_file?
      @template.size > 20_000
    end

    def parse_output(out)
      warnings = []
      output = []

      out.lines.each do |l|
        if l.strip.start_with?('Line')
          warnings << l
        else
          output << l
        end
      end

      { warnings: warnings.join, output: output.join }
    end
  end
end
