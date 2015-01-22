# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'simple_date_scopes/version'

Gem::Specification.new do |gem|
  gem.name          = "simple_date_scopes"
  gem.version       = SimpleDateScopes::VERSION
  gem.authors       = ["Peter Hoeg"]
  gem.email         = ["peter@speartail.com"]
  gem.description   = %q{A set of standard date scopes to handle years, months and weeks based on created_at or another field}
  gem.summary       = %q{A set of standard date scopes to handle years, months and weeks based on created_at or another field}
  gem.homepage      = 'http://www.github.com/stex/date_scopes'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'activerecord', '~> 2.3'
  gem.add_development_dependency 'rake'
end
