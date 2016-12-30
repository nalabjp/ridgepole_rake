module RidgepoleRake
  module OptionKeys
    module V051
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
        verbose
        debug
        version
        v
      ).freeze

      SINGLE_CHAR_KEYS = V050::SINGLE_CHAR_KEYS
    end
  end
end
