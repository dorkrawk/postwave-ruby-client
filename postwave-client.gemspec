# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'postwave/version'

Gem::Specification.new do |spec|
  spec.name          = "postwave-client"
  spec.version       = Postwave::VERSION
  spec.authors       = ["Dave Schwantes"]
  spec.email         = ["dave.schwantes@gmail.com"]

  spec.summary       = "A Ruby client for interacting with Postwave blogs."
  spec.description   = "Write your posts statically. Interact with them dynamically."
  spec.homepage      = "https://github.com/dorkrawk/postwave-client-ruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ["lib"]

  # spec.add_dependency ""

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake", "~> 12.3"
end
