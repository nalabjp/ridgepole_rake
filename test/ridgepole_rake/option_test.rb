require 'test_helper'

class RidgepoleRake::OptionTest < Minitest::Test
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
end
