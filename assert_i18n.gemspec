# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{assert_i18n}
  s.version = "0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Tom Lea"]
  s.date = %q{2009-01-13}
  s.description = %q{A collection of `I18n` assertions I use in daily life.}
  s.email = %q{commits@tomlea.co.uk}
  s.extra_rdoc_files = ["README.textile"]
  s.files = ["Rakefile", "README.textile", "lib/assert_i18n/core_ext.rb", "lib/assert_i18n/test_helper.rb", "lib/assert_i18n.rb", "test/functional/test_helper_test.rb", "rails/init.rb"]
  s.has_rdoc = true
  s.rdoc_options = ["--line-numbers", "--inline-source", "--main", "README.textile"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.0}
  s.summary = %q{A collection of `I18n` assertions I use in daily life.}
  s.test_files = ["test/functional/test_helper_test.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
