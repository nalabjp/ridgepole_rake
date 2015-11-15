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
      if !!config.bundler[:clean_system]
        Bunder.clean_system(command)
      else
        system(command)
      end
    end

    def command
      build if stash.empty?
      join
    end

    private

    def build
      add_action
      add_dry_run
      add_require_options
      add_misc
      add_env
      add_db_config
      add_ridgepole
    end

    def join
      stash.join(' ').strip
    end

    def add_action
      case action
      when :apply
        stash.push('--apply')
        stash.push('--file', config.ridgepole.fetch(:file))
        add_table_options
      when :merge
        stash.push('--merge')
        stash.push('--file', options[:table_or_patch])
        add_table_options
      when :export
        stash.push('--export')
        stash.push('--output', config.ridgepole.fetch(:output))
      when :diff
        stash.push('--diff', database_configuration, config.ridgepole.fetch(:file))
      else
        raise UndefinedActionError, "Undefined action: '#{action}'"
      end
    end

    def add_table_options
      stash.push('--table_options', config.ridgepole[:table_options]) if config.ridgepole[:table_options]
    end

    def add_dry_run
      stash.push('--dry-run') if options[:dry_run]
    end

    def add_require_options
      stash.push('--require', config.ridgepole[:require]) if config.ridgepole[:require]
    end

    def add_misc
      stash.push(config.ridgepole[:misc]) if config.ridgepole[:misc]
    end

    def add_env
      stash.push('--env', config.ridgepole.fetch(:env))
    end

    def add_db_config
      stash.push('--config', database_configuration)
    end

    def add_ridgepole
      stash.unshift('ridgepole')
      stash.unshift('bundle exec') if config.bundler[:enable]
    end

    def database_configuration
      if config.brancher[:enable] && (yaml = database_configuration_with_brancher)
        yaml
      else
        config.ridgepole.fetch(:config)
      end
    end

    def database_configuration_with_brancher
      begin
        require 'brancher'
        require 'erb'
        configurations = YAML.load(ERB.new(File.read(config.ridgepole.fetch(:config))).result)
        Brancher::DatabaseRenameService.rename!(configurations, config.ridgepole.fetch(:env))
        yaml = configurations[config.ridgepole.fetch(:env)].to_yaml
        yaml.sub(/---\n/, '') if action.eql?(:diff)
        yaml
      rescue LoadError
      end
    end
  end

  class UndefinedActionError < StandardError; end
end
