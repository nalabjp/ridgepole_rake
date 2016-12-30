module RidgepoleRake
  module OptionKeys
    module V065Beta14
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

      # @note Same as V064
      RECOGNIZED_KEYS = %w(
        table-options
        alter-extra
        external-script
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
        mysql-use-alter
        dump-without-table-options
        dump-with-default-fk-name
        index-removed-drop-column
        require
        r
        log-file
        verbose
        debug
        version
        v
      ).freeze

      # @note Same as V064
      NON_VALUE_KEYS = %w(
        bulk-change
        reverse
        with-apply
        enable-mysql-awesome
        mysql-use-alter
        dump-without-table-options
        dump-with-default-fk-name
        index-removed-drop-column
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
