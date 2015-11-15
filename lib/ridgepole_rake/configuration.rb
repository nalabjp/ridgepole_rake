module RidgepoleRake
  class Configuration
    attr_accessor :ridgepole

    def initialize
      @ridgepole = default_ridgepole_options.with_indifferent_access
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
  end
end
