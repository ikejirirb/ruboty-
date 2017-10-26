# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ruboty/ehon/version'

Gem::Specification.new do |spec|
  spec.name          = "ruboty-ehon"
  spec.version       = Ruboty::Ehon::VERSION
  spec.authors       = ["Risa Harada", "Rie Kato"]
  spec.email         = ["supikateriburu@gmail.com", "katoriexxxkatorie@gmail.com"]

  spec.summary       = %q{Memorize your EHON (picture book) when you read, and recommend EHON.}
  spec.homepage      = "https://github.com/ikejirirb/ruboty-ehon"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_dependency "ruboty"
end
