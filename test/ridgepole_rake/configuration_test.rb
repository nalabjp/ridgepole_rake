require 'test_helper'

class RidgepoleRake::ConfigurationTest < Minitest::Test
  def setup
    RidgepoleRake.instance_variable_set(:@config, nil)
  end

  def test_config
    assert_equal 'config/database.yml', RidgepoleRake.config.ridgepole[:config]

    RidgepoleRake.configure do |config|
      config.ridgepole[:config] = 'new_db_config'
    end

    assert_equal 'new_db_config', RidgepoleRake.config.ridgepole[:config]
  end

  def test_file
    assert_equal 'db/schemas/Schemafile', RidgepoleRake.config.ridgepole[:file]

    RidgepoleRake.configure do |config|
      config.ridgepole[:file] = 'new_schema_dir/new_schema_file'
    end

    assert_equal 'new_schema_dir/new_schema_file', RidgepoleRake.config.ridgepole[:file]
  end

  def test_output
    assert_equal 'db/schemas.dump/Schemafile', RidgepoleRake.config.ridgepole[:output]

    RidgepoleRake.configure do |config|
      config.ridgepole[:output] = 'new_schema_dir.dump/new_schema_file'
    end

    assert_equal 'new_schema_dir.dump/new_schema_file', RidgepoleRake.config.ridgepole[:output]
  end

  def test_env
    assert_equal 'test', RidgepoleRake.config.ridgepole[:env]

    RidgepoleRake.configure do |config|
      config.ridgepole[:env] = 'production'
    end

    assert_equal 'production', RidgepoleRake.config.ridgepole[:env]
  end

  def test_use_brancher
    assert RidgepoleRake.config.brancher[:use]

    RidgepoleRake.configure do |config|
      config.brancher[:use] = false
    end

    assert_equal false, RidgepoleRake.config.brancher[:use]
  end

  def test_use_bundler
    assert RidgepoleRake.config.bundler[:use]

    RidgepoleRake.configure do |config|
      config.bundler[:use] = false
    end

    assert_equal false, RidgepoleRake.config.bundler[:use]
  end

  def test_use_clean_system
    assert RidgepoleRake.config.bundler[:clean_system]

    RidgepoleRake.configure do |config|
      config.bundler[:clean_system] = false
    end

    assert_equal false, RidgepoleRake.config.bundler[:clean_system]
  end
end
