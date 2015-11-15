require 'erb'

module RidgepoleRake
  module Brancher
    module Configuration
      def self.prepended(klass)
        klass.class_eval { attr_accessor :brancher }
      end

      # @note override
      def initialize
        super
        @brancher = { enable: true }.with_indifferent_access
      end
    end

    module Command
      private

      # @note override
      def add_config
        stash.push('--config', database_configuration)
      end

      def database_configuration
        if config.brancher[:enable] && (yaml = database_configuration_with_brancher rescue nil)
          yaml
        else
          config.ridgepole.fetch(:config)
        end
      end

      def database_configuration_with_brancher
        configurations = YAML.load(ERB.new(File.read(config.ridgepole.fetch(:config))).result)
        ::Brancher::DatabaseRenameService.rename!(configurations, config.ridgepole.fetch(:env))
        yaml = configurations[config.ridgepole.fetch(:env)].to_yaml
        yaml.sub(/---\n/, '') if action.eql?(:diff)
        yaml
      end

      # @note override
      def add_diff_action
        stash.push('--diff', database_configuration, config.ridgepole.fetch(:file))
      end
    end
  end
end

RidgepoleRake::Configuration.__send__(:prepend, RidgepoleRake::Brancher::Configuration)
RidgepoleRake::Command.__send__(:prepend, RidgepoleRake::Brancher::Command)
