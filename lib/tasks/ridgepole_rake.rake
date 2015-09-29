namespace :ridgepole do
  task :configure do
    # If you want to configure your configuration, please define the task with the same name as 'ridgepole:configure'.
    #
    # e.g.
    #   # /rails_root_path/lib/tasks/ridgepole.rake
    #
    #   namespace :ridgepole do
    #     task :configure do
    #       RidgepoleRake.schema_file_path = 'db/schema_file'
    #       RidgepoleRake.schema_dump_path = 'db/output'
    #     end
    #   end
    #
    #   # It is also possible to use the block instead of accessor.
    #   namespace :ridgepole do
    #     task :configure do
    #       RidgepoleRake.configure do |config|
    #         config.schema_file_path = 'db/schema_file'
    #         config.schema_dump_path = 'db/output'
    #       end
    #     end
    #   end
  end

  desc '`ridgepole --apply` with requirements options'
  task apply: %i( environment configure ) do
    RidgepoleRake::Tasks.apply
  end

  desc '`ridgepole --apply --dry-run` with requirements options'
  namespace :apply do
    task 'dry-run' => %i( environment configure ) do
      RidgepoleRake::Tasks.apply(dry_run: true)
    end
  end

  desc '`ridgepole --export` with requirements options'
  task export: %i( environment configure ) do
    RidgepoleRake::Tasks.export
  end

  desc '`rake db:drop`, `rake db:create` and `ridgepole --apply` with requirements options'
  task reset: %i( environment configure ) do
    ActiveRecord::Tasks::DatabaseTasks.drop_current
    ActiveRecord::Tasks::DatabaseTasks.create_current
    RidgepoleRake::Tasks.apply
  end

  desc 'diff current db schema and current schema file'
  task diff: %i( environment configure ) do
    RidgepoleRake::Tasks.diff
  end
end
