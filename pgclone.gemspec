# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pgclone/version'

Gem::Specification.new do |spec|
  spec.name          = "pgclone"
  spec.version       = Pgclone::VERSION
  spec.authors       = ["Sasha Klein"]
  spec.email         = ["sashafklein@gmail.com"]

  spec.summary       = %q{A simple tool for cloning a production database to local.}
  spec.description   = %q{For PostgreSQL only.}
  spec.homepage      = "https://www.github.com/sashafklein/pgclone"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   = ['pgclone']
  spec.require_paths = ["lib"]

  spec.test_files = spec.files.grep(%r{^(spec)/})
  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_runtime_dependency "trollop", '2.1.2'
end
