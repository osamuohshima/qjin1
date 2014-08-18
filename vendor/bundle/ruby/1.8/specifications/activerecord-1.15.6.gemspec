# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{activerecord}
  s.version = "1.15.6"

  s.required_rubygems_version = nil if s.respond_to? :required_rubygems_version=
  s.authors = ["David Heinemeier Hansson"]
  s.autorequire = %q{active_record}
  s.cert_chain = nil
  s.date = %q{2007-11-23}
  s.description = %q{Implements the ActiveRecord pattern (Fowler, PoEAA) for ORM. It ties database tables and classes together for business objects, like Customer or Subscription, that can find, save, and destroy themselves without resorting to manual SQL.}
  s.email = %q{david@loudthinking.com}
  s.homepage = %q{http://www.rubyonrails.org}
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new("> 0.0.0")
  s.rubyforge_project = %q{activerecord}
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{Implements the ActiveRecord pattern for ORM.}

  if s.respond_to? :specification_version then
    s.specification_version = 1

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, ["= 1.4.4"])
    else
      s.add_dependency(%q<activesupport>, ["= 1.4.4"])
    end
  else
    s.add_dependency(%q<activesupport>, ["= 1.4.4"])
  end
end
