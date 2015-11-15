require 'active_support/core_ext/hash'

module RidgepoleRake
  class Configuration
    attr_accessor :ridgepole, :brancher, :bundler

    def initialize
      @ridgepole = default_ridgepole_options.with_indifferent_access
      @brancher  = default_brancher_options.with_indifferent_access
      @bundler   = default_bundler_options.with_indifferent_access
    end

    private

    def default_ridgepole_options
      env = begin
              require 'rails'
              Rails.env
            rescue LoadError
              'development'
            end
      {
        config: 'config/database.yml',
        file:   'db/schemas/Schemafile',
        output: 'db/schemas.dump/Schemafile',
        env:    env,
      }
    end

    def default_brancher_options
      enable = begin
                 require 'brancher'
                 true
               rescue LoadError
                 false
               end
      {
        enable: enable
      }
    end

    def default_bundler_options
      enable = begin
                 require 'bundler'
                 true
               rescue LoadError
                 false
               end
      {
        enable:       enable,
        clean_system: enable
      }
    end
  end
end
