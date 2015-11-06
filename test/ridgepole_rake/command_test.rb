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
end
