require "rubygems"
require "test/unit"
require "i18n"

require File.join(File.dirname(__FILE__), *%w[.. rails init])


class Test::Unit::TestCase
  def teardown
    I18n.backend = nil
    I18n.locale = nil
  end
end
