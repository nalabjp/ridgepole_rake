require 'test_helper'

class RidgepoleTasksTest < Minitest::Test
  def setup
    @args = []
    @run_mock = Minitest::Mock.new
    @run_mock.expect(:call, nil) do |action, options|
      @args.push(action, options)
    end
  end

  def test_apply_without_args
    RidgepoleRake::Tasks.stub(:run, @run_mock) do
      RidgepoleRake::Tasks.apply
    end

    assert @run_mock.verify
    assert_equal :apply, @args[0]
    assert_equal false, @args[1][:dry_run]
  end

  def test_apply_with_dry_run_option
    RidgepoleRake::Tasks.stub(:run, @run_mock) do
      RidgepoleRake::Tasks.apply(true)
    end

    assert @run_mock.verify
    assert_equal :apply, @args[0]
    assert_equal true, @args[1][:dry_run]
  end

  def test_merge_with_merge_file_option
    RidgepoleRake::Tasks.stub(:run, @run_mock) do
      RidgepoleRake::Tasks.merge('merge_file.rb')
    end

    assert @run_mock.verify
    assert_equal :merge, @args[0]
    assert_equal 'merge_file.rb', @args[1][:merge_file]
    assert_equal false, @args[1][:dry_run]
  end

  def test_merge_with_merge_file_and_dry_run_options
    RidgepoleRake::Tasks.stub(:run, @run_mock) do
      RidgepoleRake::Tasks.merge('merge_file.rb', true)
    end

    assert @run_mock.verify
    assert_equal :merge, @args[0]
    assert_equal 'merge_file.rb', @args[1][:merge_file]
    assert_equal true, @args[1][:dry_run]
  end

  def test_export
    RidgepoleRake::Tasks.stub(:run, @run_mock) do
      RidgepoleRake::Tasks.export
    end

    assert @run_mock.verify
    assert_equal :export, @args[0]
    assert_equal nil, @args[1]
  end

  def test_diff
    RidgepoleRake::Tasks.stub(:run, @run_mock) do
      RidgepoleRake::Tasks.diff
    end

    assert @run_mock.verify
    assert_equal :diff, @args[0]
    assert_equal nil, @args[1]
  end

  def test_run
    RidgepoleRake.instance_variable_set(:@config, nil)
    RidgepoleRake.config.bundler[:use] = false
    RidgepoleRake::Command.stub_any_instance(:execute, nil) do
      expect = "-----\nExecuted command => ridgepole --apply --file db/schemas/Schemafile --env test --config config/database.yml\n"
      assert_output(expect) do
        RidgepoleRake::Tasks.apply
      end
    end
  end
end
