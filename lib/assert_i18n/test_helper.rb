require "set"

module AssertI18n::TestHelper
  # Assert that there are no missing translations during the course of executing the block.
  def assert_no_missing_translations(message = "Did not expect missing translations.", &block)
    _wrap_assertion do
      missing_translations = missing_translations_in(&block)
      unless missing_translations.empty?
        missing_list = missing_translations.collect{|e| "   * #{e.key.inspect} in #{e.locale.inspect}"}.join("\n")
        raise Test::Unit::AssertionFailedError.new("#{message}\n  Missing translations:\n#{missing_list}")
      end
    end
  end

  def assert_all_locales_have_all_translations_available_to_the_default_locale(message = "All translations should be available in all locales")
    locales_to_check = I18n.available_locales - [I18n.default_locale.to_sym]

    required_translations = I18n.available_translations(I18n.default_locale.to_sym)

    locales_to_check.each do |target_locale|
      defined_translations = I18n.available_translations(target_locale.to_sym)
      missing_translations = required_translations - defined_translations
      if missing_translations.any?
        missing_translations_for_output = missing_translations.map{|parts| " * #{parts.join('.')}" }.join("\n")
        raise Test::Unit::AssertionFailedError.new("#{message} - Missing translations for #{target_locale.inspect}:\n#{missing_translations_for_output}")
      end
    end
  end

  def assert_localized_file_availability(file_path)
    each_locale do |locale|
      localized_file_path = file_path % [locale]
      assert File.exists?(File.join(Rails.root, localized_file_path)), "Missing localized file: #{localized_file_path} for locale #{locale}."
    end
  end

  def each_locale(&block)
    I18n.available_locales.each(&block)
  end
  
  def with_each_locale(&block)
    original_locale = I18n.locale
    each_locale do |locale|
      I18n.locale = locale
      yield
    end
  ensure
    I18n.locale = original_locale
  end

  private
  def missing_translations_in(&block)
    exception_handler = I18n.exception_handler
    missing_translations = Set.new

    I18n.exception_handler = :exceptions_to_proc
    I18n.exceptions_to_proc = proc{|e, *args|
     raise e unless e.is_a? I18n::MissingTranslationData
     missing_translations << e
     e.message
    }

    yield

    missing_translations.to_a
  ensure
    I18n.exception_handler = exception_handler
  end
end
