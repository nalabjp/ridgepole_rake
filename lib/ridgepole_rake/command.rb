module RidgepoleRake
  class Command
    attr_accessor :stash, :action, :config, :options

    def initialize(action, config, options = {})
      @stash   = []
      @action  = action
      @config  = config
      @options = options
    end

    def exec
      if !!config.use_clean_system
        Bunder.clean_system(command)
      else
        system(command)
      end
    end

    private 

    def command
      reset
      build
      prepare
    end

    def reset
      stash.clear
    end

    def build
      add_action
      add_dry_run
      add_require
      add_misc
      add_env
      add_db_config
      add_ridgepole
    end

    def prepare
      stash.join(' ')
    end

    def add_action
      case action
      when :apply
        stash.push('--file', config.schema_file_path)
        add_table_options
      when :merge
        stash.push('--file', options[:table_or_patch])
        add_table_options
      when :export
        stash.push('--output', config.schema_dump_path)
      when :diff
        stash.push('--diff', *config.diff_files) # TODO: db config with brancher?
      else
        raise UndefinedActionError, "Undefined action: '#{action}'"
      end
    end

    def add_table_options
      stash.push('--table_options', config.table_options) if config.table_options
    end

    def dry_run
      stash.push('--dry-run') if options[:dry_run]
    end

    def add_require
      stash.push('--require', config.require) if config.require
    end

    def add_misc
      stash.push(config.misc) if config.misc
    end

    def add_env
      stash.push('--env', config.env)
    end

    def add_db_config
      stash.push('--config', config.db_config)
    end

    def add_ridgepole
      stash.unshift('ridgepole')
      stash.unshift('bundle exec') if config.use_bundler
    end
  end

  class UndefinedActionError < StandardError; end
end
