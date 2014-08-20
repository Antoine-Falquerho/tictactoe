# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tictactoe/version'

Gem::Specification.new do |spec|
  spec.name          = "tictactoe"
  spec.version       = Tictactoe::VERSION
  spec.authors       = ["Antoine Falquerho"]
  spec.email         = ["antoine.falquerho@gmail.com"]
  spec.description   = "Tic Tac Toe"
  spec.summary       = "Whatever you do, you lose"
  spec.homepage      = ""
  spec.license       = "MIT"

  # spec.files         = `git ls-files`.split($/)
  spec.files       = Dir["README.md","Gemfile","Rakefile", "spec/*", "lib/**/*"]

  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
