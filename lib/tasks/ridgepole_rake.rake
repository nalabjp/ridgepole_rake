namespace :ridgepole do
  desc '`ridgepole --apply`'
  task apply: :environment do
    RidgepoleRake::Tasks.apply
  end

  desc '`ridgepole --apply --dry-run`'
  namespace :apply do
    task 'dry-run' => :environment do
      RidgepoleRake::Tasks.apply(true)
    end
  end

  desc '`ridgepole --merge`'
  task :merge, [:merge_file] => :environment do
    raise 'Require table schema file or execution file' if args.merge_file.blank?

    RidgepoleRake::Tasks.merge(args.merge_file)
  end

  desc '`ridgepole --merge --dry-run`'
  namespace :merge do
    task 'dry-run', [:merge_file] => :environment do
      raise 'Require table schema file or execution file' if args.merge_file.blank?

      RidgepoleRake::Tasks.merge(args.merge_file, true)
    end
  end

  desc '`ridgepole --export`'
  task export: :environment do
    RidgepoleRake::Tasks.export
  end

  desc '`rake db:drop`, `rake db:create` and `ridgepole --apply`'
  task reset: :environment do
    ActiveRecord::Tasks::DatabaseTasks.drop_current
    ActiveRecord::Tasks::DatabaseTasks.create_current
    RidgepoleRake::Tasks.apply
  end

  desc 'diff current db schema and current schema file'
  task diff: :environment do
    RidgepoleRake::Tasks.diff
  end
end
