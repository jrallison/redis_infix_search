# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'infix/version'

Gem::Specification.new do |spec|
  spec.name          = "infix"
  spec.version       = Infix::VERSION
  spec.authors       = ["John Allison"]
  spec.email         = ["jrallison@gmail.com"]
  spec.description   = %q{TODO: Write a gem description}
  spec.summary       = %q{TODO: Write a gem summary}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency("activesupport")
  spec.add_dependency("redis")
  spec.add_dependency("hiredis")
  spec.add_dependency("redis-namespace")
end
