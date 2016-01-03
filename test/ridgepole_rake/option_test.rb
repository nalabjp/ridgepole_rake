require 'test_helper'

class RidgepoleRake::OptionTest < Minitest::Test
  def setup
    RidgepoleRake.reset
    RidgepoleRake::Option.clear
  end

  def teardown
    RidgepoleRake::Option.clear
  end

  def test_non_value_key?
    RidgepoleRake::Option.stub(:non_value_keys, %w(x y)) do
      assert RidgepoleRake::Option.non_value_key?('x')
      assert RidgepoleRake::Option.non_value_key?('y')
      assert !RidgepoleRake::Option.non_value_key?('xy')
    end
  end

  def test_add_hyphens_if_needed
    RidgepoleRake::Option.stub(:single_char_keys, %w(x y)) do
      assert_equal '-x', RidgepoleRake::Option.add_hyphens_if_needed('x')
      assert_equal '-y', RidgepoleRake::Option.add_hyphens_if_needed('y')
      assert_equal '--foo', RidgepoleRake::Option.add_hyphens_if_needed('foo')
      assert_equal '--foo-bar', RidgepoleRake::Option.add_hyphens_if_needed('foo-bar')
      assert_equal '--baz', RidgepoleRake::Option.add_hyphens_if_needed('--baz')
    end
  end

  def test_ignored_keys
    RidgepoleRake::Option.stub(:stash, {'ignored_keys' => ['a', 'b']}) do
      assert_equal ['a', 'b'], RidgepoleRake::Option.ignored_keys
    end
  end

  def test_recognized_keys
    RidgepoleRake::Option.stub(:stash, {'recognized_keys' => ['c', 'd']}) do
      assert_equal ['c', 'd'], RidgepoleRake::Option.recognized_keys
    end
  end

  def test_non_value_keys
    RidgepoleRake::Option.stub(:stash, {'non_value_keys' => ['e', 'f']}) do
      assert_equal ['e', 'f'], RidgepoleRake::Option.non_value_keys
    end
  end

  def test_single_char_keys
    RidgepoleRake::Option.stub(:stash, {'single_char_keys' => ['g', 'h']}) do
      assert_equal ['g', 'h'], RidgepoleRake::Option.single_char_keys
    end
  end

  def test_stash_in_version_0_5_0
    exp_hash = {
      'ignored_keys' => %w(
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
      ),
      'recognized_keys' => %w(
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
      ),
      'non_value_keys' => %w(
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
      ),
      'single_char_keys' => %w(
        t
        v
      )
    }

    RidgepoleRake::Option.stub(:ridgepole_version, '0.5.0') do
      assert_equal exp_hash, RidgepoleRake::Option.__send__(:stash)
    end
  end

  def test_stash_in_version_0_5_1
    exp_hash = {
      'ignored_keys' => %w(
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
      ),
      'recognized_keys' => %w(
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
      ),
      'non_value_keys' => %w(
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
      ),
      'single_char_keys' => %w(
        t
        v
      )
    }

    RidgepoleRake::Option.stub(:ridgepole_version, '0.5.1') do
      assert_equal exp_hash, RidgepoleRake::Option.__send__(:stash)
    end
  end

  def test_stash_in_version_0_5_2
    exp_hash = {
      'ignored_keys' => %w(
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
      ),
      'recognized_keys' => %w(
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
      ),
      'non_value_keys' => %w(
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
      ),
      'single_char_keys' => %w(
        r
        t
        v
      )
    }

    RidgepoleRake::Option.stub(:ridgepole_version, '0.5.2') do
      assert_equal exp_hash, RidgepoleRake::Option.__send__(:stash)
    end
  end

  def test_stash_in_version_0_6_0_to_0_6_2
    exp_hash = {
      'ignored_keys' => %w(
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
      ),
      'recognized_keys' => %w(
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
        require
        r
        log-file
        verbose
        debug
        version
        v
      ),
      'non_value_keys' => %w(
        bulk-change
        reverse
        with-apply
        enable-mysql-awesome
        dump-without-table-options
        index-removed-drop-column
        verbose
        debug
        version
        v
      ),
      'single_char_keys' => %w(
        r
        t
        v
      )
    }

    %w(0.6.0 0.6.1 0.6.2).each do |version|
      RidgepoleRake::Option.stub(:ridgepole_version, version) do
        assert_equal exp_hash, RidgepoleRake::Option.__send__(:stash)
      end
    end
  end

  def test_stash_in_version_0_6_3
    exp_hash = {
      'ignored_keys' => %w(
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
      ),
      'recognized_keys' => %w(
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
      ),
      'non_value_keys' => %w(
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
      ),
      'single_char_keys' => %w(
        r
        t
        v
      )
    }

    RidgepoleRake::Option.stub(:ridgepole_version, '0.6.3') do
      assert_equal exp_hash, RidgepoleRake::Option.__send__(:stash)
    end
  end
end
