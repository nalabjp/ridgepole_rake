module RidgepoleRake
  module OptionKeys
    module V050
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
        default-int-limit
        pre-query
        post-query
        reverse
        with-apply
        tables
        t
        ignore-tables
        enable-mysql-unsigned
        enable-mysql-pkdump
        enable-mysql-foreigner
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
        enable-mysql-unsigned
        enable-mysql-pkdump
        enable-mysql-foreigner
        verbose
        debug
        version
        v
      ).freeze

      SINGLE_CHAR_KEYS = %w(
        t
        v
      ).freeze
    end
  end
end
