if defined?(::Rails)
  require 'test_helper'

  class TestApp < Rails::Application
    Rails.application.load_tasks
  end

  class RidgepoleRake::RailsTest < Minitest::Test
    def test_default_env_is_test
      RidgepoleRake.instance_variable_set(:@config, nil)
      assert_equal 'test', RidgepoleRake.config.ridgepole[:env]
    end

    def test_railtie
      assert Rake::Task.task_defined?('ridgepole:apply')
      assert Rake::Task.task_defined?('ridgepole:apply:dry-run')
      assert Rake::Task.task_defined?('ridgepole:merge')
      assert Rake::Task.task_defined?('ridgepole:merge:dry-run')
      assert Rake::Task.task_defined?('ridgepole:export')
      assert Rake::Task.task_defined?('ridgepole:diff')
      assert Rake::Task.task_defined?('ridgepole:reset')
    end
  end
end
