module RidgepoleRake
  module Bundler
    module Configuration
      def self.prepended(klass)
        klass.class_eval { attr_accessor :bundler }
      end

      # @note override
      def initialize
        super
        @bundler = { use: true, clean_system: true }.with_indifferent_access
      end
    end

    module Command
      # @note override
      def execute
        if config.bundler[:use] && config.bundler[:clean_system]
          ::Bundler.clean_system(command)
        else
          # TODO: Raise stack level too deep when call `super`
          Kernel.system(command)
        end
      end

      private

      # @note override
      def add_ridgepole
        super
        stash.unshift('bundle exec') if config.bundler[:use]
      end
    end
  end
end

RidgepoleRake::Configuration.prepend(RidgepoleRake::Bundler::Configuration)
RidgepoleRake::Command.prepend(RidgepoleRake::Bundler::Command)
