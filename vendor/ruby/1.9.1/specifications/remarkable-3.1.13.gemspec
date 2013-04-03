# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "remarkable"
  s.version = "3.1.13"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Carlos Brando", "Jos\u{c3}\u{a9} Valim"]
  s.date = "2010-02-18"
  s.description = "Remarkable: a framework for rspec matchers, with support to macros and I18n."
  s.email = ["eduardobrando@gmail.com", "jose.valim@gmail.com"]
  s.extra_rdoc_files = ["README", "LICENSE", "CHANGELOG"]
  s.files = ["README", "LICENSE", "CHANGELOG"]
  s.homepage = "http://github.com/carlosbrando/remarkable"
  s.require_paths = ["lib"]
  s.rubyforge_project = "remarkable"
  s.rubygems_version = "1.8.23"
  s.summary = "Remarkable: a framework for rspec matchers, with support to macros and I18n."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rspec>, [">= 1.2.0"])
    else
      s.add_dependency(%q<rspec>, [">= 1.2.0"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 1.2.0"])
  end
end
