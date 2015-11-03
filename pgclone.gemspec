# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'p_g_clone/version'

Gem::Specification.new do |spec|
  spec.name          = "pgclone"
  spec.version       = PGClone::VERSION
  spec.authors       = ["Sasha Klein"]
  spec.email         = ["sashafklein@gmail.com"]

  spec.summary       = %q{A simple tool for cloning a production database to local.}
  spec.description   = %q{For PostgreSQL only.}
  spec.homepage      = "https://www.github.com/sashafklein/pgclone"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = ['pgclone']
  spec.require_paths = ["lib"]

  spec.test_files = spec.files.grep(%r{^(spec)/})
  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "trollop", '2.1.2'
end
