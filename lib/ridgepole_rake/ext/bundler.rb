module RidgepoleRake
  module Bundler
    module Configuration
      def self.prepended(klass)
        klass.class_eval { attr_reader :bundler }
      end

      # @note override
      def initialize
        super
        @bundler = { use: true, clean_system: true }.with_indifferent_access
      end

      def bundler=(hash)
        @bundler = hash.with_indifferent_access
      end
    end

    module Command
      # @note override
      def execute
        if config.bundler[:use] && config.bundler[:clean_system]
          ::Bundler.clean_system(*stash)
        else
          super
        end
      end

      private

      # @note override
      def add_ridgepole
        super
        stash.unshift(*%w(bundle exec)) if config.bundler[:use]
      end
    end
  end
end

RidgepoleRake::Configuration.prepend(RidgepoleRake::Bundler::Configuration)
RidgepoleRake::Command.prepend(RidgepoleRake::Bundler::Command)
