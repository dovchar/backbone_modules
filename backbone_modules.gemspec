$:.push File.expand_path("../lib", __FILE__)
require 'backbone_modules/version'

Gem::Specification.new do |gem|
  gem.authors       = ["Dmytro Ovcharenko"]
  gem.email         = ["o.snich@gmail.com"]
  gem.description   = %q{This gem will help create module structur in backbone applications}
  gem.summary       = %q{For now it is just test}
  gem.homepage      = "http://github.com/dovchar/bbm"

  gem.add_dependency 'rails', '>= 3.1'
  gem.add_dependency 'jquery-rails'
  gem.add_dependency 'ejs'
  gem.add_dependency 'eco'
  gem.add_dependency 'jasminerice' 
  gem.add_dependency 'guard-jasmine'

  gem.add_development_dependency "sqlite3"
  gem.add_development_dependency "turn"
  gem.add_development_dependency "rspec"
  gem.add_development_dependency "jasminerice"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "backbone_modules"
  gem.require_paths = ["lib"]
  gem.version       = BackboneModules::VERSION
end