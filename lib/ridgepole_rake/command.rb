module RidgepoleRake
  class Command
    attr_accessor :stash, :action, :config, :options

    def initialize(action, config, options = {})
      @stash   = []
      @action  = action
      @config  = config
      @options = options
    end

    def execute
      if !!config.use_clean_system
        Bunder.clean_system(command)
      else
        system(command)
      end
    end

    def to_s
      join.strip
    end

    private 

    def command
      reset
      build
      join
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

    def join
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
        stash.push('--diff', database_configuration, config.schema_file_path)
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
      stash.push('--config', database_configuration)
    end

    def add_ridgepole
      stash.unshift('ridgepole')
      stash.unshift('bundle exec') if config.use_bundler
    end

    def database_configuration
      if config.use_brancher && (yaml = database_configuration_with_brancher)
        yaml
      else
        config.db_config
      end
    end

    def database_configuration_with_brancher
      begin
        require 'brancher'
        configurations = YAML.load(ERB.new(File.read(config.db_config)).result)
        Brancher::DatabaseRenameService.rename!(configurations, config.env)
        yaml = configurations[config.env].to_yaml
        yaml.sub(/---\n/, '') if action.eql?(:diff)
        yaml
      rescue LoadError
      end
    end
  end

  class UndefinedActionError < StandardError; end
end
