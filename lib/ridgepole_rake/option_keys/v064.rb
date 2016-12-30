module RidgepoleRake
  module OptionKeys
    module V064
      IGNORED_KEYS = V050::IGNORED_KEYS

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

      SINGLE_CHAR_KEYS = V052::SINGLE_CHAR_KEYS
    end
  end
end
