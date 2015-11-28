if defined?(::Rails)
  require 'test_helper'

  class RidgepoleRake::RailsTest < Minitest::Test
    def test_default_env_is_test
      RidgepoleRake.instance_variable_set(:@config, nil)
      assert_equal 'test', RidgepoleRake.config.ridgepole[:env]
    end
  end
end
