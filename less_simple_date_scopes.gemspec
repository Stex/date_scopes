# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'less_simple_date_scopes/version'

Gem::Specification.new do |gem|
  gem.name          = 'less_simple_date_scopes'
  gem.version       = LessSimpleDateScopes::VERSION
  gem.authors       = ["Stefan Exner"]
  gem.email         = ["stex@sterex.de"]
  gem.description   = %q{A set of standard date scopes to handle years, months and weeks based on created_at or another field. Based on simple_date_scopes.}
  gem.summary       = %q{A set of standard date scopes to handle years, months and weeks based on created_at or another field.}
  gem.homepage      = 'http://www.github.com/stex/less_simple_date_scopes'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency             'activerecord', '~> 2.3'
  gem.add_development_dependency 'rake'
end
