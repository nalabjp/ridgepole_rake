require 'test_helper'

class RidgepoleRake::ConfigurationTest < Minitest::Test
  def setup
    RidgepoleRake.instance_variable_set(:@config, nil)
  end

  def test_db_config
    assert_equal 'config/database.yml', RidgepoleRake.config.db_config

    RidgepoleRake.configure do |config|
      config.db_config = 'new_db_config'
    end

    assert_equal 'new_db_config', RidgepoleRake.config.db_config
  end

  def test_schema_dir
    assert_equal 'db/schemas', RidgepoleRake.config.schema_dir

    RidgepoleRake.configure do |config|
      config.schema_dir = 'new_schema_dir'
    end

    assert_equal 'new_schema_dir', RidgepoleRake.config.schema_dir
  end

  def test_schema_file
    assert_equal 'Schemafile', RidgepoleRake.config.schema_file

    RidgepoleRake.configure do |config|
      config.schema_file = 'new_schema_file'
    end

    assert_equal 'new_schema_file', RidgepoleRake.config.schema_file
  end

  def test_schema_file_path
    assert_equal 'db/schemas/Schemafile', RidgepoleRake.config.schema_file_path

    RidgepoleRake.configure do |config|
      config.schema_dir = 'new_schema_dir'
      config.schema_file = 'new_schema_file'
    end

    assert_equal 'new_schema_dir/new_schema_file', RidgepoleRake.config.schema_file_path
  end

  def test_schema_dump_file_path
    assert_equal 'db/schemas.dump/Schemafile', RidgepoleRake.config.schema_dump_path

    RidgepoleRake.configure do |config|
      config.schema_dir = 'new_schema_dir'
      config.schema_file = 'new_schema_file'
    end

    assert_equal 'new_schema_dir.dump/new_schema_file', RidgepoleRake.config.schema_dump_path
  end

  def test_env
    assert_equal 'development', RidgepoleRake.config.env

    RidgepoleRake.configure do |config|
      config.env = 'production'
    end

    assert_equal 'production', RidgepoleRake.config.env
  end

  def test_table_options
    assert_nil RidgepoleRake.config.table_options

    RidgepoleRake.configure do |config|
      config.table_options = 'new_table_options'
    end

    assert_equal 'new_table_options', RidgepoleRake.config.table_options
  end

  def test_require_options
    assert_nil RidgepoleRake.config.require_options

    RidgepoleRake.configure do |config|
      config.require_options = 'new_require_options'
    end

    assert_equal 'new_require_options', RidgepoleRake.config.require_options
  end

  def test_misc
    assert_nil RidgepoleRake.config.misc

    RidgepoleRake.configure do |config|
      config.misc = 'new_misc'
    end

    assert_equal 'new_misc', RidgepoleRake.config.misc
  end

  def test_use_bundler
    assert RidgepoleRake.config.use_bundler

    RidgepoleRake.configure do |config|
      config.use_bundler = false
    end

    assert_equal false, RidgepoleRake.config.use_bundler
  end

  def test_use_clean_system
    assert RidgepoleRake.config.use_clean_system

    RidgepoleRake.configure do |config|
      config.use_clean_system = false
    end

    assert_equal false, RidgepoleRake.config.use_clean_system
  end

  def test_use_brancher
    assert_equal false, RidgepoleRake.config.use_brancher

    RidgepoleRake.configure do |config|
      config.use_brancher = true
    end

    assert RidgepoleRake.config.use_brancher
  end
end
