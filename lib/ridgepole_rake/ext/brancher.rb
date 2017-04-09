require 'erb'

module RidgepoleRake
  module Brancher
    module Configuration
      def self.prepended(klass)
        klass.class_eval { attr_reader :brancher }
      end

      # @note override
      def initialize
        super
        @brancher = { use: true }.with_indifferent_access
      end

      def brancher=(hash)
        @brancher = hash.with_indifferent_access
      end
    end

    module Command
      private

      # @note override
      def add_config
        stash.push('--config', database_configuration)
      end

      def database_configuration
        if config.brancher[:use] && (yaml = database_configuration_with_brancher)
          action.eql?(:diff) ? remove_first_line_in_yaml(yaml) : yaml
        else
          config.ridgepole.fetch(:config)
        end
      end

      def database_configuration_with_brancher
        configurations = load_configurations
        env = config.ridgepole.fetch(:env)

        ::Brancher::DatabaseRenameService.rename!(configurations, env)

        configurations[env].to_yaml
      rescue
        nil
      end

      def load_configurations
        YAML.load(ERB.new(File.read(config.ridgepole.fetch(:config))).result)
      end

      def remove_first_line_in_yaml(yaml)
        yaml.sub(/\A---\n/, '')
      end

      # @note override
      def add_diff_action
        stash.push('--diff', database_configuration, config.ridgepole.fetch(:file))
      end
    end
  end
end

RidgepoleRake::Configuration.prepend(RidgepoleRake::Brancher::Configuration)
RidgepoleRake::Command.prepend(RidgepoleRake::Brancher::Command)
