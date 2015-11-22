module RidgepoleRake
  module Bundler
    module Configuration
      def self.prepended(klass)
        klass.class_eval { attr_accessor :bundler }
      end

      # @note override
      def initialize
        super
        @bundler = { enable: true, clean_system: true }.with_indifferent_access
      end
    end

    module Command
      # @note override
      def execute
        if config.bundler[:enable] && config.bundler[:clean_system]
          ::Bundler.clean_system(command)
        else
          super
        end
      end

      private

      # @note override
      def add_ridgepole
        super
        stash.unshift('bundle exec') if config.bundler[:enable]
      end
    end
  end
end

RidgepoleRake::Configuration.__send__(:prepend, RidgepoleRake::Bundler::Configuration)
RidgepoleRake::Command.__send__(:prepend, RidgepoleRake::Bundler::Command)
