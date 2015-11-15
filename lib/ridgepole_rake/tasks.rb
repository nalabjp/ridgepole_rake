module RidgepoleRake
  class Tasks
    class << self
      attr_accessor :options

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

      def run(action, opts = {})
        opts = options.merge(opts) if options && options.is_a?(Hash)
        clear_options
        cmd = Command.new(action, RidgepoleRake.config, opts)
        cmd.execute

        result(cmd.command)
      end

      def result(command)
        puts '-----'
        puts "Executed command => #{command}"
      end

      def clear_options
        options = nil
      end
    end
  end
end
