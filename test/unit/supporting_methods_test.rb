require File.join(File.dirname(__FILE__), "..", "test_helper")

class AssertI18nHelperMethodsTest < Test::Unit::TestCase
  def test_flatten_hash_tree_keys
    result = AssertI18n.flatten_hash_tree_keys(:foo => {:bar => {:baz => 1, :bazal => 1}, :batch => 1})
    expected = [
      [:foo, :batch],
      [:foo, :bar, :baz],
      [:foo, :bar, :bazal]
    ]
    assert_equal expected, result
  end
end
