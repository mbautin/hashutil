# -*- encoding: utf-8 -*-
GEM_NAME = 'hashutil'

require File.expand_path("../lib/#{GEM_NAME}/version", __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['Mikhail Bautin']
  gem.email         = ['mbautin@gmail.com']
  gem.description   = 'Utilities for manipulating hashes'
  gem.summary       = 'Utilities for manipulating hashes'
  gem.homepage      = "http://github.com/mbautin/#{GEM_NAME}"

  gem.executables   = `git ls-files -- bin/*`.split('\n').map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split('\n').map(&:strip)
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split('\n')
  gem.name          = GEM_NAME
  gem.require_paths = ['lib']
  gem.version       = HashUtil::VERSION
  gem.add_development_dependency 'rake'
end
