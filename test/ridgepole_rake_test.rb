require 'test_helper'

class RidgepoleRakeTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::RidgepoleRake::VERSION
  end

  def test_configure
    old_db_config = RidgepoleRake.config.ridgepole.fetch(:config)
    new_db_config = 'new_' + old_db_config
    RidgepoleRake.configure do |config|
      config.ridgepole[:config] = new_db_config
    end

    assert_equal new_db_config, RidgepoleRake.config.ridgepole.fetch(:config)
  end

  def test_config
    assert RidgepoleRake.config.instance_of?(RidgepoleRake::Configuration)
  end
end
