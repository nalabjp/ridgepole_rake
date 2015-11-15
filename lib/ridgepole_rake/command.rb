module RidgepoleRake
  class Command
    IGNORE_KEYS = %w(
      apply
      a
      merge
      m
      export
      e
      diff
      d
      config
      c
      env
      E
      file
      f
      output
      o
      dry-run
    ).freeze

    NON_VALUE_KEYS = %w(
      bulk-change
      split
      split-with-dir
      reverse
      with-apply
      enable-mysql-awesome
      dump-without-table-options
      index-removed-drop-column
      enable-migration-comments
      verbose
      debug
      version
      v
    ).freeze

    IGNORE_OPTION_KEYS = %i(
      dry_run
      merge_file
    ).freeze

    attr_reader :stash, :action, :config, :options

    def initialize(action, config, options = {})
      @stash   = []
      @action  = action
      @config  = config
      @options = options
    end

    def execute
      system(command)
    end

    def command
      build if stash.empty?
      join
    end

    private

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
        v = nil if NON_VALUE_KEYS.include?(k)
        k = k.size.eql?(1) ? "-#{k}" : "--#{k}"
        arr.push(k, v)
      end.compact
    end

    def configurable_options
      config.ridgepole.except(*IGNORE_KEYS).merge(options.except(*IGNORE_OPTION_KEYS))
    end

    def add_ridgepole
      stash.unshift('ridgepole')
    end
  end

  class UndefinedActionError < StandardError; end
end
