if defined?(::Bundler)
  require 'test_helper'

  class RidgepoleRake::BundlerTest < Minitest::Test
    def setup
      RidgepoleRake.reset
    end

    def test_bundler
      assert RidgepoleRake.config.bundler[:use]
      assert RidgepoleRake.config.bundler[:clean_system]

      RidgepoleRake.config.bundler = { use: false, clean_system: false }

      assert_equal false, RidgepoleRake.config.bundler[:use]
      assert_equal false, RidgepoleRake.config.bundler[:clean_system]
    end

    def test_execute_with_bundler_clean_system
      mock = Minitest::Mock.new
      Bundler.stub(:clean_system, mock) do
        RidgepoleRake::Command.new(:apply, RidgepoleRake.config).execute
      end

      assert mock.verify
    end
  end
end
