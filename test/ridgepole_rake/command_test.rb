require 'test_helper'

class RidgepoleRake::CommandTest < Minitest::Test
  def setup
    RidgepoleRake.instance_variable_set(:@config, nil)
  end

  def test_command_with_apply_action
    action = :apply
    config = RidgepoleRake.config
    exp = 'bundle exec ridgepole --apply --file db/schemas/Schemafile --env development --config config/database.yml'

    assert_equal exp, RidgepoleRake::Command.new(action, config).command
  end

  def test_command_with_export_action
    action = :export
    config = RidgepoleRake.config
    exp = 'bundle exec ridgepole --export --output db/schemas.dump/Schemafile --env development --config config/database.yml'

    assert_equal exp, RidgepoleRake::Command.new(action, config).command
  end

  def test_command_with_diff_action
    action = :diff
    config = RidgepoleRake.config
    exp = 'bundle exec ridgepole --diff config/database.yml db/schemas/Schemafile --env development --config config/database.yml'

    assert_equal exp, RidgepoleRake::Command.new(action, config).command
  end

  def test_command_with_merge_action
    action = :merge
    config = RidgepoleRake.config
    options = { table_or_patch: 'patch_file.rb' }
    exp = 'bundle exec ridgepole --merge --file patch_file.rb --env development --config config/database.yml'

    assert_equal exp, RidgepoleRake::Command.new(action, config, options).command
  end

  def test_command_with_dry_run_option
    action = :apply
    config = RidgepoleRake.config
    options = { dry_run: true }
    exp = 'bundle exec ridgepole --apply --file db/schemas/Schemafile --dry-run --env development --config config/database.yml'

    assert_equal exp, RidgepoleRake::Command.new(action, config, options).command
  end

  def test_commnad_with_require_options_option
    action = :apply
    config = RidgepoleRake.config
    config.require_options = 'requires.rb'
    exp = 'bundle exec ridgepole --apply --file db/schemas/Schemafile --require requires.rb --env development --config config/database.yml'

    assert_equal exp, RidgepoleRake::Command.new(action, config).command
  end

  def test_command_with_misc_option
    action = :apply
    config = RidgepoleRake.config
    config.misc = '--add-any-option'
    exp = 'bundle exec ridgepole --apply --file db/schemas/Schemafile --add-any-option --env development --config config/database.yml'

    assert_equal exp, RidgepoleRake::Command.new(action, config).command
  end

  def test_command_with_env_option
    action = :apply
    config = RidgepoleRake.config
    config.env = 'staging'
    exp = 'bundle exec ridgepole --apply --file db/schemas/Schemafile --env staging --config config/database.yml'

    assert_equal exp, RidgepoleRake::Command.new(action, config).command
  end

  def test_commnad_with_db_config_option
    action = :apply
    config = RidgepoleRake.config
    config.db_config = 'config/custom_database.yml'
    exp = 'bundle exec ridgepole --apply --file db/schemas/Schemafile --env development --config config/custom_database.yml'

    assert_equal exp, RidgepoleRake::Command.new(action, config).command
  end

  def test_commnad_with_db_config_option_and_use_brancher
    # TODO
  end

  def test_command_without_bundler
    action = :apply
    config = RidgepoleRake.config
    config.use_bundler = false
    exp = 'ridgepole --apply --file db/schemas/Schemafile --env development --config config/database.yml'

    assert_equal exp, RidgepoleRake::Command.new(action, config).command
  end
end
