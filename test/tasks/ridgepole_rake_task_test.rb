require 'test_helper'

class RidgepoleRakeTaskTest < Minitest::Test
  unless Rake::Task.task_defined?('ridgepole:apply')
    load File.expand_path('../../lib/tasks/ridgepole_rake.rake', File.dirname(__FILE__))
  end

  def setup
    @mock = Minitest::Mock.new
  end


  def test_task_apply
    RidgepoleRake::Tasks.stub(:apply, @mock) do
      Rake::Task['ridgepole:apply'].invoke
    end

    assert @mock.verify
  end

  def test_task_apply_dry_run
    RidgepoleRake::Tasks.stub(:apply, @mock) do
      Rake::Task['ridgepole:apply:dry-run'].invoke
    end

    assert @mock.verify
  end

  def test_task_merge
    RidgepoleRake::Tasks.stub(:merge,@mock) do
      Rake::Task['ridgepole:merge'].invoke('file_path')
    end

    assert @mock.verify
  end

  def test_task_merge_dry_run
    RidgepoleRake::Tasks.stub(:merge, @mock) do
      Rake::Task['ridgepole:merge:dry-run'].invoke('file_path')
    end

    assert @mock.verify
  end

  def test_task_export
    RidgepoleRake::Tasks.stub(:export, @mock) do
      Rake::Task['ridgepole:export'].invoke
    end

    assert @mock.verify
  end

  def test_task_diff
    RidgepoleRake::Tasks.stub(:diff, @mock) do
      Rake::Task['ridgepole:diff'].invoke
    end

    assert @mock.verify
  end

  if defined?(ActiveRecord)
    def test_task_reset
      ActiveRecord::Tasks::DatabaseTasks.stub(:drop_current, nil) do
        ActiveRecord::Tasks::DatabaseTasks.stub(:create_current, nil) do
          RidgepoleRake::Tasks.stub(:apply, @mock) do
            Rake::Task['ridgepole:reset'].invoke
          end
        end
      end

      assert @mock.verify
    end
  end
end
