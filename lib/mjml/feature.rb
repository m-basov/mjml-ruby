module MJML
  # Allows to check if feature is availalbe in current mjml version
  class Feature
    def self.version
      semver = MJML.executable_version.split('.')
      @version ||= Hash[
        major: semver[0].to_i,
        minor: semver[1].to_i,
        patch: semver[2].to_i
      ]
    end

    def self.available?(feature_name)
      case feature_name
      when :validation_level
        version[:major] >= 3
      else
        false
      end
    end

    def self.missing?(feature_name)
      !available?(feature_name)
    end
  end
end
