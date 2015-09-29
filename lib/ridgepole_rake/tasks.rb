module RidgepoleRake
  class Tasks
    def initialize(config)
      @config = config
    end

    def apply(dry_run = false)
      run(:apply, dry_run: dry_run)
    end

    def merge(dry_run = false)
      run(:merge, dry_run: dry_run)
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
      command.to_s
    end
  end
end
