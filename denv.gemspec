lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'denv/version'

Gem::Specification.new do |spec|
  spec.name          = 'denv'
  spec.version       = Denv::VERSION
  spec.authors       = ['Taiki Ono']
  spec.email         = ['taiks.4559@gmail.com']

  spec.summary       = %q{Loads environment variables to `ENV` from `.env` file. No special treatments about shell meta characters.}
  spec.description   = spec.summary
  spec.homepage      = 'https://github.com/taiki45/denv'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'pry-byebug'
  spec.add_development_dependency 'rails'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 3'
  spec.add_development_dependency 'spring'
end
