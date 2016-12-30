require 'ridgepole_rake/option_keys'

module RidgepoleRake
  module Option
    SUPPORTED_VERSIONS = {
      '0.5.0' => OptionKeys::V050,
      '0.5.1' => OptionKeys::V051,
      '0.5.2' => OptionKeys::V052,
      '0.6.0' => OptionKeys::V060,
      '0.6.1' => OptionKeys::V061,
      '0.6.2' => OptionKeys::V062,
      '0.6.3' => OptionKeys::V063,
      '0.6.4' => OptionKeys::V064,
      '0.6.5.beta14' => OptionKeys::V065Beta14,
    }.freeze

    class << self
      def non_value_key?(key)
        non_value_keys.include?(key.to_s)
      end

      def add_hyphens_if_needed(key)
        case key.to_s
        when /\A[#{single_char_keys.join}]\z/
          "-#{key}"
        when /\A[a-z].+\z/
          "--#{key}"
        else
          key.to_s
        end
      end

      def ignored_keys
        stash.fetch(:ignored_keys)
      end

      def recognized_keys
        stash.fetch(:recognized_keys)
      end

      def non_value_keys
        stash.fetch(:non_value_keys)
      end

      def single_char_keys
        stash.fetch(:single_char_keys)
      end

      def clear
        @stash = nil
      end

      private

      def stash
        @stash ||= {
          ignored_keys:     current_version_class::IGNORED_KEYS,
          recognized_keys:  current_version_class::RECOGNIZED_KEYS,
          non_value_keys:   current_version_class::NON_VALUE_KEYS,
          single_char_keys: current_version_class::SINGLE_CHAR_KEYS
        }
      end

      def current_version_class
        SUPPORTED_VERSIONS.fetch(ridgepole_version)
      end

      def ridgepole_version
        Ridgepole::VERSION
      end
    end
  end
end
