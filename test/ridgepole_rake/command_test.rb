require 'test_helper'

class RidgepoleRake::CommandTest < Minitest::Test
  def setup
    RidgepoleRake.instance_variable_set(:@config, nil)
    RidgepoleRake.config.ridgepole[:env] = 'test'
  end

  def test_execute
    RidgepoleRake.config.bundler[:clean_system] = false
    executed_cmd = ''
    mock = Minitest::Mock.new
    mock.expect(:call, nil) do |command|
      executed_cmd = command
    end

    Kernel.stub(:system, mock) do
      RidgepoleRake::Command.new(:apply, RidgepoleRake.config).execute
    end

    mock.verify
    assert_equal false, executed_cmd.empty?
  end

  def test_command_with_apply_action
    action = :apply
    config = RidgepoleRake.config
    exp = 'bundle exec ridgepole --apply --file db/schemas/Schemafile --env test --config config/database.yml'

    assert_equal exp, RidgepoleRake::Command.new(action, config).command
  end

  def test_command_with_export_action
    action = :export
    config = RidgepoleRake.config
    exp = 'bundle exec ridgepole --export --output db/schemas.dump/Schemafile --env test --config config/database.yml'

    assert_equal exp, RidgepoleRake::Command.new(action, config).command
  end

  def test_command_with_diff_action
    action = :diff
    config = RidgepoleRake.config
    exp = 'bundle exec ridgepole --diff config/database.yml db/schemas/Schemafile --env test --config config/database.yml'

    assert_equal exp, RidgepoleRake::Command.new(action, config).command
  end

  def test_command_with_merge_action
    action = :merge
    config = RidgepoleRake.config
    options = { merge_file: 'patch_file.rb' }
    exp = 'bundle exec ridgepole --merge --file patch_file.rb --env test --config config/database.yml'

    assert_equal exp, RidgepoleRake::Command.new(action, config, options).command
  end

  def test_command_with_invalid_action
    action = :invalid

    assert_raises(RidgepoleRake::UndefinedActionError) do
      RidgepoleRake::Command.new(action, RidgepoleRake.config).command
    end
  end

  def test_command_with_dry_run_option
    action = :apply
    config = RidgepoleRake.config
    options = { dry_run: true }
    exp = 'bundle exec ridgepole --apply --file db/schemas/Schemafile --dry-run --env test --config config/database.yml'

    assert_equal exp, RidgepoleRake::Command.new(action, config, options).command
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
    exp = 'bundle exec ridgepole --apply --file db/schemas/Schemafile --env test --config config/custom_database.yml'

    assert_equal exp, RidgepoleRake::Command.new(action, config).command
  end

  def test_command_without_bundler
    action = :apply
    config = RidgepoleRake.config
    config.bundler[:use] = false
    exp = 'ridgepole --apply --file db/schemas/Schemafile --env test --config config/database.yml'

    assert_equal exp, RidgepoleRake::Command.new(action, config).command
  end

  def test_command_with_extras
    action = :apply
    config = RidgepoleRake.config
    config.ridgepole.merge!({
      'table-options'              => 'ENGINE=INNODB',
      'bulk-change'                => 'ignore_value',
      'default-bool-limit'         => 1,
      'default-int-limit'          => 2,
      'default-float-limit'        => 3,
      'default-string-limit'       => 4,
      'default-text-limit'         => 5,
      'default-binary-limit'       => 6,
      'pre-query'                  => '"any query1"',
      'post-query'                 => '"any query2"',
      'split'                      => nil,
      'split-with-dir'             => '',
      'reverse'                    => true,
      'with-apply'                 => true,
      'tables'                     => 'table1',
      't'                          => 'table1',
      'ignore-tables'              => 'table2',
      'enable-mysql-awesome'       => true,
      'dump-without-table-options' => true,
      'index-removed-drop-column'  => true,
      'enable-migration-comments'  => true,
      'require'                    => 'requires.rb',
      'r'                          => 'requires.rb',
      'log-file'                   => 'log-file.log',
      'verbose'                    => true,
      'debug'                      => true,
      'version'                    => true,
      'v'                          => true
    }) # Ridgepole v0.6.3 only
    exp = 'bundle exec ridgepole --apply --file db/schemas/Schemafile --env test --config config/database.yml --table-options ENGINE=INNODB --bulk-change --default-bool-limit 1 --default-int-limit 2 --default-float-limit 3 --default-string-limit 4 --default-text-limit 5 --default-binary-limit 6 --pre-query "any query1" --post-query "any query2" --split --split-with-dir --reverse --with-apply --tables table1 -t table1 --ignore-tables table2 --enable-mysql-awesome --dump-without-table-options --index-removed-drop-column --enable-migration-comments --require requires.rb -r requires.rb --log-file log-file.log --verbose --debug --version -v'

    assert_equal exp, RidgepoleRake::Command.new(action, config).command
  end
end
