module RidgepoleRake
  module Option
    extend self

    def non_value_key?(key)
      non_value_keys.include?(key.to_s)
    end

    def add_hyphens_if_needed(key)
      case key.to_s
      when /\A[#{single_char_keys}]\z/
        "-#{key}"
      when /\A[a-z].+\z/
        "--#{key}"
      else
        key.to_s
      end
    end

    def ignored_keys
      stash.fetch('ignore_keys')
    end

    def recognized_keys
      stash.fetch('recognized_keys')
    end

    def non_value_keys
      stash.fetch('non_value_keys')
    end

    def single_char_keys
      stash.fetch('single_char_keys')
    end

    private

    def stash
      @stash ||= YAML.load_file(yaml_path).fetch(Ridgepole::VERSION)
    end

    def yaml_path
      File.expand_path('option_keys.yml', File.dirname(__FILE__))
    end
  end
end
