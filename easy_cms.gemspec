# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'easy_cms/version'

Gem::Specification.new do |spec|
  spec.add_dependency "jquery-rails", "~> 4.3"

  spec.name          = "easy_cms"
  spec.version       = EasyCms::VERSION
  spec.authors       = ["Martin Villalba"]
  spec.email         = ["14tinchov@gmail.com"]

  spec.summary       = %q{Create a simple CMS with a Material Template}
  spec.description   = %q{Create a simple CMS with a Material Template and create scaffolding with automated task styles}
  spec.homepage      = "https://github.com/14tinchov/easy_cms"
  spec.license       = "MIT"

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
