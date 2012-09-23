# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'date_scopes/version'

Gem::Specification.new do |gem|
  gem.name          = "date_scopes"
  gem.version       = DateScopes::VERSION
  gem.authors       = ["Peter Hoeg"]
  gem.email         = ["peter@speartail.com"]
  gem.description   = %q{A set of standard date scopes to handle years, months and weeks based on created_at}
  gem.summary       = %q{A set of standard date scopes to handle years, months and weeks based on created_at}
  gem.homepage      = "http://speartail.com"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'activerecord', '~> 3.0'

  gem.add_development_dependency 'factory_girl'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'sqlite3'
  gem.add_development_dependency 'timecop', '>= 0.5.1'
end
