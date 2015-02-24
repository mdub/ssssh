# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ssssh/version'

Gem::Specification.new do |spec|

  spec.name          = "ssssh"
  spec.version       = Ssssh::VERSION
  spec.summary       = %q{It's a secret!}
  spec.description   = %q{"ssssh" is a small tool that can be used to encrypt and decrypt secrets, using the AWS "Key Management Service" (KMS).
}
  spec.license       = "MIT"

  spec.authors       = ["Mike Williams"]
  spec.email         = ["mdub@dogbiscuit.org"]
  spec.homepage      = "https://github.com/mdub/ssssh"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "aws-sdk-core", "~> 2.0"
  spec.add_runtime_dependency "clamp", "~> 0.6"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"

end
