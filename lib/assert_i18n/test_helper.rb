require "set"
module AssertI18n::TestHelper
  # Assert that there are no missing translations during the course of executing the block.
  def assert_no_missing_translations(message = "Did not expect missing translations.", &block)
    exception_handler = I18n.exception_handler
    missing_translations = Set.new

    I18n.exception_handler = :exceptions_to_proc
    I18n.exceptions_to_proc = proc{|*args|
      e = args.first
     if e.is_a? I18n::MissingTranslationData
       missing_translations << args
       e.message
     else
       p args
       raise e
     end
    }
    
    yield
    
    _wrap_assertion do
      unless missing_translations.empty?
        missing_list = missing_translations.collect{|(e, locale, key)|"   * #{key.inspect} in #{locale.inspect}"}.join("\n")
        raise Test::Unit::AssertionFailedError.new("#{message}\n  Missing translations:\n#{missing_list}")
      end
    end
    
  ensure
    I18n.exception_handler = exception_handler
  end
end
