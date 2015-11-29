Rake::Task.define_task :environment unless Rake::Task.task_defined?(:environment)

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
  task :merge, [:file] => :environment do |_t, args|
    raise 'Require table schema file or execution file' if args.file.blank?

    RidgepoleRake::Tasks.merge(args.file)
  end

  desc '`ridgepole --merge --dry-run`'
  namespace :merge do
    task 'dry-run', [:file] => :environment do |_t, args|
      raise 'Require table schema file or execution file' if args.file.blank?

      RidgepoleRake::Tasks.merge(args.file, true)
    end
  end

  desc '`ridgepole --export`'
  task export: :environment do
    RidgepoleRake::Tasks.export
  end

  desc 'diff current db schema and current schema file'
  task diff: :environment do
    RidgepoleRake::Tasks.diff
  end

  if defined?(ActiveRecord)
    desc '`rake db:drop`, `rake db:create` and `ridgepole --apply`'
    task reset: :environment do
      ActiveRecord::Tasks::DatabaseTasks.drop_current
      ActiveRecord::Tasks::DatabaseTasks.create_current
      RidgepoleRake::Tasks.apply
    end
  end
end
