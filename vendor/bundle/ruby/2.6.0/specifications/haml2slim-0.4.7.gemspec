# -*- encoding: utf-8 -*-
# stub: haml2slim 0.4.7 ruby lib

Gem::Specification.new do |s|
  s.name = "haml2slim".freeze
  s.version = "0.4.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Fred Wu".freeze]
  s.date = "2013-05-24"
  s.description = "Convert Haml templates to Slim templates.".freeze
  s.email = ["ifredwu@gmail.com".freeze]
  s.executables = ["haml2slim".freeze]
  s.extra_rdoc_files = ["README.md".freeze]
  s.files = ["README.md".freeze, "bin/haml2slim".freeze]
  s.homepage = "http://github.com/fredwu/haml2slim".freeze
  s.rdoc_options = ["--charset=UTF-8".freeze]
  s.rubygems_version = "3.3.9".freeze
  s.summary = "Haml to Slim converter.".freeze

  s.installed_by_version = "3.3.9" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<haml>.freeze, [">= 3.0"])
    s.add_runtime_dependency(%q<nokogiri>.freeze, [">= 0"])
    s.add_runtime_dependency(%q<ruby_parser>.freeze, [">= 0"])
    s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    s.add_development_dependency(%q<slim>.freeze, [">= 1.0.0"])
  else
    s.add_dependency(%q<haml>.freeze, [">= 3.0"])
    s.add_dependency(%q<nokogiri>.freeze, [">= 0"])
    s.add_dependency(%q<ruby_parser>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<slim>.freeze, [">= 1.0.0"])
  end
end
