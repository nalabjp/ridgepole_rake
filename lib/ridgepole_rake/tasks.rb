module RidgepoleRake
  class Tasks
    class << self
      def apply(dry_run = false)
        run(:apply, dry_run: dry_run)
      end

      def merge(merge_file, dry_run = false)
        run(:merge, merge_file: merge_file, dry_run: dry_run)
      end

      def export
        run(:export)
      end

      def diff
        run(:diff)
      end

      private

      def run(action, options = {})
        cmd = Command.new(action, RidgepoleRake.config, options)
        cmd.execute

        result(cmd.command)
      end

      def result(command)
        puts '-----'
        puts "Executed command => #{command}"
      end
    end
  end
end
