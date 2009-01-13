require "i18n"

module AssertI18n::CoreExt
  def self.hook!
    ::I18n.send(:include, I18n)
  end
  
  module I18n
    def self.included(m)
      m.extend(ClassMethods)
    end
    
    module ClassMethods
      def exception_handler
        class_variable_get :@@exception_handler
      end
      
      def exceptions_to_proc(*args)
        @@exceptions_to_proc.call(*args) if @@exceptions_to_proc
      end
      
      def exceptions_to_proc=(proc)
        @@exceptions_to_proc = proc
      end
    end
  end
end

AssertI18n::CoreExt.hook!
