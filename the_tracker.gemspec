# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'the_tracker/version'

Gem::Specification.new do |gem|
  gem.name          = "the_tracker"
  gem.version       = TheTracker::VERSION
  gem.authors       = ["Jorge Alvarez"]
  gem.email         = ["jorge@alvareznavarro.es"]
  gem.description   = %q{Add tracking codes to your rails app}
  gem.summary       = %q{Analytics, Website Optimizer, Clicktale...}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_dependency "rails"
  gem.add_development_dependency "rspec-rails"
  gem.add_development_dependency "guard-rspec"
  gem.add_development_dependency "pry"
end
