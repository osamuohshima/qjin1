# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{actionwebservice}
  s.version = "1.2.6"

  s.required_rubygems_version = nil if s.respond_to? :required_rubygems_version=
  s.authors = ["Leon Breedt"]
  s.autorequire = %q{action_web_service}
  s.cert_chain = nil
  s.date = %q{2007-11-23}
  s.description = %q{Adds WSDL/SOAP and XML-RPC web service support to Action Pack}
  s.email = %q{bitserf@gmail.com}
  s.homepage = %q{http://www.rubyonrails.org}
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new("> 0.0.0")
  s.requirements = ["none"]
  s.rubyforge_project = %q{aws}
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{Web service support for Action Pack.}

  if s.respond_to? :specification_version then
    s.specification_version = 1

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<actionpack>, ["= 1.13.6"])
      s.add_runtime_dependency(%q<activerecord>, ["= 1.15.6"])
    else
      s.add_dependency(%q<actionpack>, ["= 1.13.6"])
      s.add_dependency(%q<activerecord>, ["= 1.15.6"])
    end
  else
    s.add_dependency(%q<actionpack>, ["= 1.13.6"])
    s.add_dependency(%q<activerecord>, ["= 1.15.6"])
  end
end
