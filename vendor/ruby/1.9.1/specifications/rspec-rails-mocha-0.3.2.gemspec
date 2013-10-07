# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "rspec-rails-mocha"
  s.version = "0.3.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Mislav Marohni\u{107}", "Paul Rosania"]
  s.date = "2012-05-04"
  s.description = "Ports functionality of mock_model and stub_model from rspec-rails using Mocha."
  s.email = "mislav.marohnic@gmail.com"
  s.homepage = "http://github.com/mislav/rspec-rails-mocha"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.23"
  s.summary = "Mocha versions of mock_model and stub_model from rspec-rails"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<mocha>, [">= 0.9.8"])
      s.add_runtime_dependency(%q<rspec-rails>, [">= 2.0.0"])
    else
      s.add_dependency(%q<mocha>, [">= 0.9.8"])
      s.add_dependency(%q<rspec-rails>, [">= 2.0.0"])
    end
  else
    s.add_dependency(%q<mocha>, [">= 0.9.8"])
    s.add_dependency(%q<rspec-rails>, [">= 2.0.0"])
  end
end
