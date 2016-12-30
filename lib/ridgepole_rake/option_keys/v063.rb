module RidgepoleRake
  module OptionKeys
    module V063
      # @note Same as V050
      IGNORED_KEYS = %w(
        config
        c
        env
        E
        apply
        a
        merge
        m
        file
        f
        dry-run
        export
        e
        diff
        d
        output
        o
        split
        split-with-dir
      ).freeze

      RECOGNIZED_KEYS = %w(
        table-options
        bulk-change
        default-bool-limit
        default-int-limit
        default-float-limit
        default-string-limit
        default-text-limit
        default-binary-limit
        pre-query
        post-query
        reverse
        with-apply
        tables
        t
        ignore-tables
        enable-mysql-awesome
        dump-without-table-options
        index-removed-drop-column
        enable-migration-comments
        require
        r
        log-file
        verbose
        debug
        version
        v
      ).freeze

      NON_VALUE_KEYS = %w(
        bulk-change
        reverse
        with-apply
        enable-mysql-awesome
        dump-without-table-options
        index-removed-drop-column
        enable-migration-comments
        verbose
        debug
        version
        v
      ).freeze

      # @note Same as V052
      SINGLE_CHAR_KEYS = %w(
        r
        t
        v
      ).freeze
    end
  end
end
