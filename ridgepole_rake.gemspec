# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ridgepole_rake/version'

Gem::Specification.new do |spec|
  spec.name          = 'ridgepole_rake'
  spec.version       = RidgepoleRake::VERSION
  spec.authors       = ['nalabjp']
  spec.email         = ['nalabjp@gmail.com']

  spec.summary       = %q{Rake Tasks for Ridgepole.}
  spec.description   = %q{Rake Tasks for Ridgepole.}
  spec.homepage      = 'https://github.com/nalabjp/ridgepole_rake'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'ridgepole', '>= 0.5', '< 0.6.5'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
end
