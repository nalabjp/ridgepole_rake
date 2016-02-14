require 'test_helper'

class RidgepoleRake::ConfigurationTest < Minitest::Test
  def setup
    RidgepoleRake.reset
  end

  def test_ridgepole
    assert_equal 'config/database.yml', RidgepoleRake.config.ridgepole[:config]
    assert_equal 'db/schemas/Schemafile', RidgepoleRake.config.ridgepole[:file]
    assert_equal 'db/schemas.dump/Schemafile', RidgepoleRake.config.ridgepole[:output]
    if defined?(::Rails)
      assert_equal 'test', RidgepoleRake.config.ridgepole[:env]
    else
      assert_equal 'development', RidgepoleRake.config.ridgepole[:env]
    end

    RidgepoleRake.config.ridgepole = {
      config: 'new_db_config',
      file: 'new_schema_dir/new_schema_file',
      output: 'new_schema_dir.dump/new_schema_file',
      env: 'production'
    }

    assert_equal 'new_db_config', RidgepoleRake.config.ridgepole[:config]
    assert_equal 'new_schema_dir/new_schema_file', RidgepoleRake.config.ridgepole[:file]
    assert_equal 'new_schema_dir.dump/new_schema_file', RidgepoleRake.config.ridgepole[:output]
    assert_equal 'production', RidgepoleRake.config.ridgepole[:env]
  end
end
