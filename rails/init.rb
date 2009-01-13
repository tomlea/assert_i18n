require File.join(File.dirname(__FILE__), *%w[.. lib assert_i18n])
require File.join(File.dirname(__FILE__), *%w[.. lib assert_i18n core_ext])
require File.join(File.dirname(__FILE__), *%w[.. lib assert_i18n test_helper])

AssertI18n::CoreExt.hook!
