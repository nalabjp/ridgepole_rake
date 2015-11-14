module RidgepoleRake
  class Configuration
    attr_accessor :ridgepole, :brancher, :bundler

    def initialize
      @ridgepole = Ridgepole.new
      @brancher  = Brancher.new
      @bundler   = Bundler.new
    end

    private

    class Ridgepole
      include ActiveSupport::Configurable

      config_accessor :config, :schema_path, :export_path, :env

      def initialize
        @config      = 'config/database.yml'
        @schema_path = 'db/schemas/Schemafile'
        @schema_path = 'db/schemas.dump/Schemafile'
        @env         = begin
                         require 'rails'
                         Rails.env
                       rescue LoadError
                         'development'
                       end
      end
    end

    class Brancher
      include ActiveSupport::Configurable

      config_accessor :enable

      def initialize
        @enable = begin
                    require 'brancher'
                    true
                  rescue LoadError
                    false
                  end
      end
    end

    class Bundler
      include ActiveSupport::Configurable

      config_accessor :enable, :clean_system

      def initialize
        @enable = begin
                    require 'bundler'
                    true
                  rescue LoadError
                    false
                  end
        @clean_system = @enable
      end
    end
  end
end
