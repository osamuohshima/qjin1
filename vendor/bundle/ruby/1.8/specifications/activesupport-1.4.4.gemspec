# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{activesupport}
  s.version = "1.4.4"

  s.required_rubygems_version = nil if s.respond_to? :required_rubygems_version=
  s.authors = ["David Heinemeier Hansson"]
  s.cert_chain = nil
  s.date = %q{2007-10-12}
  s.description = %q{Utility library which carries commonly used classes and goodies from the Rails framework}
  s.email = %q{david@loudthinking.com}
  s.homepage = %q{http://www.rubyonrails.org}
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new("> 0.0.0")
  s.rubyforge_project = %q{activesupport}
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{Support and utility classes used by the Rails framework.}

  if s.respond_to? :specification_version then
    s.specification_version = 1

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
