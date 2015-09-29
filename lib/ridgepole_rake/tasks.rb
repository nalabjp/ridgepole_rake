module RidgepoleRake
  class Tasks
    def initialize(config)
      @config = config
    end

    def apply(dry_run = false)
      run(:apply, dry_run: dry_run)
    end

    def merge(table_or_patch, dry_run = false)
      run(:merge, table_or_patch: table_or_patch, dry_run: dry_run)
    end

    def export
      run(:export)
    end

    def diff
      run(:diff)
    end

    private

    def run(action, options = {})
      command = Command.new(action, @config, options)
      command.execute

      result(command.to_s)
    end

    def result(command)
      puts '-----'
      puts "Executed command => #{command}"
    end
  end
end
