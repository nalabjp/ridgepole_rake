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

  desc '`ridgepole --apply`'
  task apply: %i( environment configure ) do
    RidgepoleRake::Tasks.apply
  end

  desc '`ridgepole --apply --dry-run`'
  task 'apply_dry-run' => %i( environment configure ) do
    RidgepoleRake::Tasks.apply(true)
  end

  desc '`ridgepole --merge`'
  task :merge, [:table_or_patch] => %i( environment configure ) do
    raise 'Require table schema file or patch file' if args.table_or_patch.blank?

    RidgepoleRake::Tasks.merge(args.table_or_patch)
  end

  desc '`ridgepole --merge --dry-run`'
  task 'merge_dry-run', [:table_or_patch] => %i( environment configure ) do
    raise 'Require table schema file or patch file' if args.table_or_patch.blank?

    RidgepoleRake::Tasks.merge(args.table_or_patch, true)
  end

  desc '`ridgepole --export`'
  task export: %i( environment configure ) do
    RidgepoleRake::Tasks.export
  end

  desc '`rake db:drop`, `rake db:create` and `ridgepole --apply`'
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
