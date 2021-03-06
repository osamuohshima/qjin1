# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{actionpack}
  s.version = "1.13.6"

  s.required_rubygems_version = nil if s.respond_to? :required_rubygems_version=
  s.authors = ["David Heinemeier Hansson"]
  s.autorequire = %q{action_controller}
  s.cert_chain = nil
  s.date = %q{2007-11-23}
  s.description = %q{Eases web-request routing, handling, and response as a half-way front, half-way page controller. Implemented with specific emphasis on enabling easy unit/integration testing that doesn't require a browser.}
  s.email = %q{david@loudthinking.com}
  s.homepage = %q{http://www.rubyonrails.org}
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new("> 0.0.0")
  s.requirements = ["none"]
  s.rubyforge_project = %q{actionpack}
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{Web-flow and rendering framework putting the VC in MVC.}

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
