module RidgepoleRake
  class Command

    attr_reader :stash, :action, :config, :options

    def initialize(action, config, options = {})
      @stash   = []
      @action  = action
      @config  = config
      @options = options
    end

    def execute
      Kernel.system(command)
    end

    def command
      @command ||= begin
                     clear
                     build
                     join
                   end
    end

    private

    def clear
      stash.clear
    end

    def build
      add_action
      add_dry_run
      add_env
      add_config
      add_extras
      add_ridgepole
    end

    def join
      stash.join(' ').strip
    end

    def add_action
      case action
      when :apply, :merge, :export, :diff
        __send__("add_#{action}_action")
      else
        raise UndefinedActionError, "Undefined action: '#{action}'"
      end
    end

    def add_apply_action
      stash.push('--apply')
      stash.push('--file', config.ridgepole.fetch(:file))
    end

    def add_merge_action
      stash.push('--merge')
      stash.push('--file', options[:merge_file])
    end

    def add_export_action
      stash.push('--export')
      stash.push('--output', config.ridgepole.fetch(:output))
      stash.push('--split') if config.ridgepole.has_key?(:split)
      stash.push('--split-with-dir') if config.ridgepole.has_key?('split-with-dir')
    end

    def add_diff_action
      stash.push('--diff', config.ridgepole.fetch(:config), config.ridgepole.fetch(:file))
    end

    def add_dry_run
      stash.push('--dry-run') if options[:dry_run]
    end

    def add_env
      stash.push('--env', config.ridgepole.fetch(:env))
    end

    def add_config
      stash.push('--config', config.ridgepole.fetch(:config))
    end

    def add_extras
      stash.concat(extra_options)
    end

    def extra_options
      configurable_options.each_with_object([]) do |(k, v), arr|
        v = nil if Option.non_value_key?(k)
        k = Option.add_hyphens_if_needed(k)
        arr.push(k, v)
      end.compact
    end

    def configurable_options
      config.ridgepole.except(*Option.ignored_keys).slice(*Option.recognized_keys)
    end

    def add_ridgepole
      stash.unshift('ridgepole')
    end
  end

  class UndefinedActionError < StandardError; end
end
