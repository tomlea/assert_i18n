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
