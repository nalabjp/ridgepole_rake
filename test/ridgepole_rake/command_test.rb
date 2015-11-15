require 'test_helper'

class RidgepoleRake::CommandTest < Minitest::Test
  def setup
    RidgepoleRake.instance_variable_set(:@config, nil)
    RidgepoleRake.config.brancher[:enable] = false
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
    config.ridgepole[:require] = 'requires.rb'
    exp = 'bundle exec ridgepole --apply --file db/schemas/Schemafile --require requires.rb --env development --config config/database.yml'

    assert_equal exp, RidgepoleRake::Command.new(action, config).command
  end

  def test_command_with_misc_option
    action = :apply
    config = RidgepoleRake.config
    config.ridgepole[:misc] = '--add-any-option'
    exp = 'bundle exec ridgepole --apply --file db/schemas/Schemafile --add-any-option --env development --config config/database.yml'

    assert_equal exp, RidgepoleRake::Command.new(action, config).command
  end

  def test_command_with_env_option
    action = :apply
    config = RidgepoleRake.config
    config.ridgepole[:env] = 'staging'
    exp = 'bundle exec ridgepole --apply --file db/schemas/Schemafile --env staging --config config/database.yml'

    assert_equal exp, RidgepoleRake::Command.new(action, config).command
  end

  def test_commnad_with_db_config_option
    action = :apply
    config = RidgepoleRake.config
    config.ridgepole[:config] = 'config/custom_database.yml'
    exp = 'bundle exec ridgepole --apply --file db/schemas/Schemafile --env development --config config/custom_database.yml'

    assert_equal exp, RidgepoleRake::Command.new(action, config).command
  end

  def test_commnad_with_db_config_option_and_use_brancher
    action = :apply
    config = RidgepoleRake.config
    config.brancher[:enable] = true
    config.ridgepole[:env] = 'custom_environment'
    config.ridgepole[:config] = 'test/fixtures/database_config.yml'

    branch_name = 'use_brancher'
    renamed_yaml = <<-EOYAML
---
user: custom_user
password: custom_password
database: custom_#{branch_name}
original_database: custom
    EOYAML
    renamed_yaml.chomp!

    exp = "bundle exec ridgepole --apply --file db/schemas/Schemafile --env custom_environment --config #{renamed_yaml}"

    Brancher::DatabaseRenameService.stub(:suffix, "_#{branch_name}") do
      assert_equal exp, RidgepoleRake::Command.new(action, config).command
    end
  end

  def test_command_without_bundler
    action = :apply
    config = RidgepoleRake.config
    config.bundler[:enable] = false
    exp = 'ridgepole --apply --file db/schemas/Schemafile --env development --config config/database.yml'

    assert_equal exp, RidgepoleRake::Command.new(action, config).command
  end
end
