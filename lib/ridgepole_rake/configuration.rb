module RidgepoleRake
  class Configuration
    attr_reader :ridgepole

    def initialize
      @ridgepole = default_ridgepole_options.with_indifferent_access
    end

    def ridgepole=(hash)
      @ridgepole = hash.with_indifferent_access
    end

    private

    def default_ridgepole_options
      {
        config: 'config/database.yml',
        file:   'db/schemas/Schemafile',
        output: 'db/schemas.dump/Schemafile',
        env:    'development',
      }
    end
  end
end
