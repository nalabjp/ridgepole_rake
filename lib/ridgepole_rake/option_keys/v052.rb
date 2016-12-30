module RidgepoleRake
  module OptionKeys
    module V052
      IGNORED_KEYS = V050::IGNORED_KEYS

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
        enable-migration-comments
        normalize-mysql-float
        enable-mysql-awesome
        mysql-awesome-unsigned-pk
        dump-without-table-options
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
        enable-mysql-unsigned
        enable-mysql-pkdump
        enable-mysql-foreigner
        enable-migration-comments
        normalize-mysql-float
        enable-mysql-awesome
        mysql-awesome-unsigned-pk
        dump-without-table-options
        verbose
        debug
        version
        v
      ).freeze

      SINGLE_CHAR_KEYS = %w(
        r
        t
        v
      ).freeze
    end
  end
end
