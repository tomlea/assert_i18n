require File.join(File.dirname(__FILE__), "..", "test_helper")

class EqualLocalesTestHelperTest < Test::Unit::TestCase
  include AssertI18n::TestHelper

  def setup
    I18n.backend.store_translations :'en', {:foo => "Bar", :nested => {:translation => {:should => "Work"} } }
    I18n.backend.store_translations :'pirate', { :nested => { :translation => { :should => "Wark me hearties!" } }, :foo => "Barrrr!" } 
  end

  def test_should_not_raise_a_test_failure
    assert_nothing_raised() { assert_all_locales_have_all_translations_available_to_the_default_locale }
  end

  def test_should_show_deeply_nested_translation_keys_correctly
    I18n.backend.store_translations :'en', { :nested => { :translations => { :should => { :work => "and not show the values" } } } }
    e = assert_raise(Test::Unit::AssertionFailedError) { assert_all_locales_have_all_translations_available_to_the_default_locale }
    assert_match %r/ * nested.translations.should.work$/, e.message
  end
end


class UnequalLocalesTestHelperTest < Test::Unit::TestCase
  include AssertI18n::TestHelper

  def setup
    I18n.backend.store_translations :'en', { :bar => { :foo => "Bar" } }
    I18n.backend.store_translations :'pirate', {:bar => { } }
  end

  def test_should_raise_a_test_failure_for_none_matching_nested_keys
    e = assert_raise(Test::Unit::AssertionFailedError) { assert_all_locales_have_all_translations_available_to_the_default_locale }
    assert_match %r/Missing translations for :pirate/, e.message
    assert_match %r/ * bar.foo/, e.message
  end
end
