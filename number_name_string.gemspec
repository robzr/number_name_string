# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'number_name_string/version'

Gem::Specification.new do |spec|
  spec.name          = "number_name_string"
  spec.version       = NumberNameString::VERSION
  spec.authors       = ["Rob Zwissler"]
  spec.email         = ["rob@zwissler.org"]

  spec.summary       = %q{Converts to and from numbers and names (ie: 16.to_name == 'sixteen')}
  spec.description   = %q{Converts to and from numbers and names (ie: 16.to_name == 'sixteen', 'forty.to_i == 40). Pure Ruby with no dependencies outside of the standard library.}
  spec.homepage      = "https://github.com/robzr/number_name_string"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
