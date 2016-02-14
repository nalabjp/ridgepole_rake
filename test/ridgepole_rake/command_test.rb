require 'test_helper'

class RidgepoleRake::CommandTest < Minitest::Test
  def setup
    RidgepoleRake.reset
    RidgepoleRake.config.ridgepole[:env] = 'test'
  end

  def test_execute
    config = RidgepoleRake.config
    config.bundler[:use] = false
    config.bundler[:clean_system] = false
    expected_cmds = %w(ridgepole --apply --file db/schemas/Schemafile --env test --config config/database.yml)
    actual_cmds = []
    mock = Minitest::Mock.new
    mock.expect(:call, nil) do |commands|
      actual_cmds = commands
    end

    Kernel.stub(:system, mock) do
      RidgepoleRake::Command.new(:apply, config).execute
    end

    mock.verify
    assert_equal expected_cmds, actual_cmds
  end

  def test_command_with_apply_action
    action = :apply
    config = RidgepoleRake.config
    exp = 'bundle exec ridgepole --apply --file db/schemas/Schemafile --env test --config config/database.yml'

    assert_equal exp, RidgepoleRake::Command.new(action, config).inspect
  end

  def test_command_with_export_action
    action = :export
    config = RidgepoleRake.config
    exp = 'bundle exec ridgepole --export --output db/schemas.dump/Schemafile --env test --config config/database.yml'

    assert_equal exp, RidgepoleRake::Command.new(action, config).inspect
  end

  def test_command_with_export_action_and_split_option
    action = :export
    config = RidgepoleRake.config
    config.ridgepole[:split] = true
    exp = 'bundle exec ridgepole --export --output db/schemas.dump/Schemafile --split --env test --config config/database.yml'

    assert_equal exp, RidgepoleRake::Command.new(action, config).inspect
  end

  def test_command_with_export_action_and_split_with_dir_option
    action = :export
    config = RidgepoleRake.config
    config.ridgepole['split-with-dir'] = true
    exp = 'bundle exec ridgepole --export --output db/schemas.dump/Schemafile --split-with-dir --env test --config config/database.yml'

    assert_equal exp, RidgepoleRake::Command.new(action, config).inspect
  end

  def test_command_with_diff_action
    action = :diff
    config = RidgepoleRake.config
    exp = 'bundle exec ridgepole --diff config/database.yml db/schemas/Schemafile --env test --config config/database.yml'

    assert_equal exp, RidgepoleRake::Command.new(action, config).inspect
  end

  def test_command_with_merge_action
    action = :merge
    config = RidgepoleRake.config
    options = { merge_file: 'patch_file.rb' }
    exp = 'bundle exec ridgepole --merge --file patch_file.rb --env test --config config/database.yml'

    assert_equal exp, RidgepoleRake::Command.new(action, config, options).inspect
  end

  def test_command_with_invalid_action
    action = :invalid

    assert_raises(RidgepoleRake::UndefinedActionError) do
      RidgepoleRake::Command.new(action, RidgepoleRake.config).inspect
    end
  end

  def test_command_with_dry_run_option
    action = :apply
    config = RidgepoleRake.config
    options = { dry_run: true }
    exp = 'bundle exec ridgepole --apply --file db/schemas/Schemafile --dry-run --env test --config config/database.yml'

    assert_equal exp, RidgepoleRake::Command.new(action, config, options).inspect
  end

  def test_command_with_env_option
    action = :apply
    config = RidgepoleRake.config
    config.ridgepole[:env] = 'staging'
    exp = 'bundle exec ridgepole --apply --file db/schemas/Schemafile --env staging --config config/database.yml'

    assert_equal exp, RidgepoleRake::Command.new(action, config).inspect
  end

  def test_commnad_with_db_config_option
    action = :apply
    config = RidgepoleRake.config
    config.ridgepole[:config] = 'config/custom_database.yml'
    exp = 'bundle exec ridgepole --apply --file db/schemas/Schemafile --env test --config config/custom_database.yml'

    assert_equal exp, RidgepoleRake::Command.new(action, config).inspect
  end

  def test_command_without_bundler
    action = :apply
    config = RidgepoleRake.config
    config.bundler[:use] = false
    exp = 'ridgepole --apply --file db/schemas/Schemafile --env test --config config/database.yml'

    assert_equal exp, RidgepoleRake::Command.new(action, config).inspect
  end

  def test_command_with_extras
    action = :apply
    config = RidgepoleRake.config
    config.ridgepole.merge!({
      'table-options'              => 'ENGINE=INNODB',
      'alter-extra'                => 'LOCK=NONE',
      'external-script'            => './test.sh',
      'bulk-change'                => 'ignore_value',
      'default-bool-limit'         => 1,
      'default-int-limit'          => 2,
      'default-float-limit'        => 3,
      'default-string-limit'       => 4,
      'default-text-limit'         => 5,
      'default-binary-limit'       => 6,
      'pre-query'                  => '"any query1"',
      'post-query'                 => '"any query2"',
      'reverse'                    => true,
      'with-apply'                 => true,
      'tables'                     => 'table1',
      't'                          => 'table1',
      'ignore-tables'              => 'table2',
      'enable-mysql-awesome'       => true,
      'mysql-use-alter'            => true,
      'dump-without-table-options' => true,
      'dump-with-default-fk-name'  => true,
      'index-removed-drop-column'  => true,
      'require'                    => 'requires.rb',
      'r'                          => 'requires.rb',
      'log-file'                   => 'log-file.log',
      'verbose'                    => true,
      'debug'                      => true,
      'version'                    => true,
      'v'                          => true
    }) # Ridgepole v0.6.4 only
    exp = 'bundle exec ridgepole --apply --file db/schemas/Schemafile --env test --config config/database.yml --table-options ENGINE=INNODB --alter-extra LOCK=NONE --external-script ./test.sh --bulk-change --default-bool-limit 1 --default-int-limit 2 --default-float-limit 3 --default-string-limit 4 --default-text-limit 5 --default-binary-limit 6 --pre-query "any query1" --post-query "any query2" --reverse --with-apply --tables table1 -t table1 --ignore-tables table2 --enable-mysql-awesome --mysql-use-alter --dump-without-table-options --dump-with-default-fk-name --index-removed-drop-column --require requires.rb -r requires.rb --log-file log-file.log --verbose --debug --version -v'

    assert_equal exp, RidgepoleRake::Command.new(action, config).inspect
  end
end
