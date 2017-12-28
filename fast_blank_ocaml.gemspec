# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'fast_blank_ocaml'
  spec.version       = '0.0.0'
  spec.authors       = ['Alexander Komarov']
  spec.email         = ['ak@akxcv.com']

  spec.summary       = 'String#blank? in OCaml'
  spec.description   = 'A simple example of how to write a Ruby native extension in OCaml'
  spec.homepage      = 'https://github.com/akxcv/fast_blank_ocaml'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 2.2.0'

  spec.extensions = ['ext/ocaml-blank/Rakefile']

  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'benchmark-ips'
  spec.add_development_dependency 'fast_blank'

  spec.add_dependency 'ffi'
end
