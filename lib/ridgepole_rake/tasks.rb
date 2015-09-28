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
      Command.new(action, @config, options).exec
    end
  end
end
