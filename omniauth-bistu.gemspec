# encoding: utf-8

require File.expand_path('../lib/omniauth-bistu/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['fmyzjs']
  gem.email         = ['root@idefs.com']
  gem.description   = %q{OmniAuth OAuth2 strategy for Bistu.}
  gem.summary       = %q{OmniAuth OAuth2 strategy for Bistu.}
  gem.homepage      = 'https://github.com/fmyzjs/omniauth-bistu'

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = 'omniauth-bistu-oauth2'
  gem.require_paths = ['lib']
  gem.version       = OmniAuth::Bistu::VERSION

  gem.add_dependency 'omniauth', '~> 1.0'
  gem.add_dependency 'omniauth-oauth2', '~> 1.1'
end
