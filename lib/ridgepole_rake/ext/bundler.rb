module RidgepoleRake
  module Bundler
    module Configuration
      def self.prepended(klass)
        klass.class_eval { attr_reader :bundler }
      end

      # @note override
      def initialize
        super
        @bundler = { use: true, clean_system: true, with_clean_env: nil }.with_indifferent_access
      end

      def bundler=(hash)
        @bundler = hash.with_indifferent_access
      end
    end

    module Command
      # @note override
      def execute
        if use_with_clean_env?
          ::Bundler.with_clean_env do
            config.bundler[:with_clean_env].call
            super
          end
        elsif use_clean_system?
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

      def use_with_clean_env?
        config.bundler[:use] && config.bundler[:with_clean_env].respond_to?(:call)
      end

      def use_clean_system?
        config.bundler[:use] && config.bundler[:clean_system]
      end
    end
  end
end

RidgepoleRake::Configuration.prepend(RidgepoleRake::Bundler::Configuration)
RidgepoleRake::Command.prepend(RidgepoleRake::Bundler::Command)
