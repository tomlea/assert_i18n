require File.join(File.dirname(__FILE__), "..", "test_helper")

class TestNoMissingTranslations < Test::Unit::TestCase
  include AssertI18n::TestHelper

  def setup
    I18n.backend.store_translations(:en, {:ok => "OK"})
  end

  def test_should_not_log_a_test_failure_when_all_translations_are_available
    assert_no_missing_translations do
      I18n.t(:ok)
    end
  end

  def test_should_not_log_a_test_failure_when_no_translation_was_attempted
    assert_no_missing_translations do
    end
  end

  def test_should_log_a_test_failure_when_a_translation_fails
    assert_raise(Test::Unit::AssertionFailedError) do
      assert_no_missing_translations do
        I18n.t(:not_ok)
      end
    end
  end
end

class TestEachLocale < Test::Unit::TestCase
  include AssertI18n::TestHelper
  
  def assert_array_of_symbols_match(expected, actual, *params)
    assert_equal expected.sort_by{|v| v.to_s }, actual.sort_by{|v| v.to_s }, *params
  end
  
  def test_should_run_block_for_every_locale
    expected_locales = [:pr_PR, :en_GB, :poo_FACE].each do |locale|
      I18n.backend.store_translations(locale, {})
    end
    
    locales_run_in_block = []
    each_locale do |locale|
      locales_run_in_block << locale
    end
    
    assert_array_of_symbols_match expected_locales, locales_run_in_block
  end

  def test_should_run_block_for_every_locale_with_locale_set
    expected_locales = [:pr_PR, :en_GB, :poo_FACE].each do |locale|
      I18n.backend.store_translations(locale, {})
    end
    
    locales_run_in_block = []
    with_each_locale do
      locales_run_in_block << I18n.locale
    end
    
    assert_array_of_symbols_match expected_locales, locales_run_in_block
  end

  def test_should_reset_the_locale_no_matter_what_happens
    expected_locales = [:pr_PR, :en_GB, :poo_FACE].each do |locale|
      I18n.backend.store_translations(locale, {})
    end
    
    I18n.locale = :not_a_locale_but_should_be_repected
    
    with_each_locale{}
    
    assert_equal :not_a_locale_but_should_be_repected, I18n.locale
  end
  
end
