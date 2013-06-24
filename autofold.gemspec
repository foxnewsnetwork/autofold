# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'autofold/version'

Gem::Specification.new do |spec|
  spec.name          = "autofold"
  spec.version       = Autofold::VERSION
  spec.authors       = ["Thomas Chen"]
  spec.email         = ["foxnewsnetwork@gmail.com"]
  spec.description   = %q{Scaffolds out complicated business logicm odels}
  spec.summary       = %q{More coming}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake", "~> 10.1.0"
  spec.add_development_dependency "rspec", "~> 2.13.0"
  spec.add_development_dependency "simplecov", "~> 0.7.0"
  spec.add_runtime_dependency "thor", "~> 0.19.0"
  spec.add_runtime_dependency "activesupport", ">= 3.2.0"
end
