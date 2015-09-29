module RidgepoleRake
  class Configuration
    include ActiveSupport::Configurable

    # database configuration
    config_accessor :db_config do
      'config/database.yml'
    end

    # schema dir
    config_accessor :schema_dir do
      'db/schemas'
    end

    # schema file
    config_accessor :schema_file do
      'Schemefile'
    end

    config_accessor :schema_file_path, instance_writer: false do
      "#{self.schema_dir}/#{self.schema_file}"
    end

    # schema dump file
    config_accessor :schema_dump_path, instance_writer: false do
      "#{self.schema_dir}.dump/#{self.schema_file}"
    end

    # environment
    config_accessor :env do
      defined?(Rails) ? Rails.env : 'development'
    end

    # table options
    config_accessor :table_options

    # require options
    config_accessor :require

    # misc
    config_accessor :misc

    # use Bundler
    config_accessor :use_bundler do
      !!defined?(Bundler)
    end

    # use Bundler.clean_system
    config_accessor :use_clean_system do
      self.use_bundler
    end

    config_accessor :use_brancher do
      !!defined?(Brancher)
    end
  end
end
