# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jujube/version'

Gem::Specification.new do |spec|
  spec.name = "jujube"
  spec.version = Jujube::VERSION
  spec.authors = ["Randy Coulman"]
  spec.email = ["rcoulman@gmail.com"]
  spec.description = <<EOF
Jujube provides a Ruby front-end for specifying Jenkins jobs.  It generates YAML files that
are then used as input for jenkins-job-builder.
EOF
  spec.summary = %q{Ruby front-end for jenkins-job-builder}
  spec.homepage = "https://github.com/randycoulman/jujube"
  spec.license = "MIT"

  spec.files = `git ls-files`.split($/)
  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files = spec.files.grep(%r{^(test|spec|features|acceptance)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake", "~> 10.1"
  spec.add_development_dependency "minitest", "~> 5.3"
  spec.add_development_dependency "flexmock", "~> 1.3"
end
