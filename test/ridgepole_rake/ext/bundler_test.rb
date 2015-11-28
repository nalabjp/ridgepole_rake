if defined?(::Bundler)
  require 'test_helper'

  class RidgepoleRake::BundlerTest < Minitest::Test
    def setup
      RidgepoleRake.instance_variable_set(:@config, nil)
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
