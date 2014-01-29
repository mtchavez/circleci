Gem::Specification.new do |s|
  s.name             = 'circleci'
  s.version          = '0.0.3'
  s.date             = '2014-01-29'
  s.summary          = 'Circle CI API Wrapper'
  s.description      = 'Wraps Circle CI API calls in a gem.'
  s.licenses         = ['MIT']
  s.authors          = ['Chavez']
  s.email            = 'nailsbrokeandfell@gmail.com'
  s.files            = Dir.glob("{bin,lib}/**/*") + %w[README.md]
  s.require_paths    = ['lib']
  s.homepage         = 'http://github.com/mtchavez/circleci'
  s.rdoc_options     = ['--charset=UTF-8 --main=README.md']
  s.extra_rdoc_files = ['README.md']

  # Gem Dependencies
  s.add_dependency 'rest-client', '~> 1.6.7', '>= 1.6.7'
  s.add_dependency 'hashie', '~> 1.2.0', '>= 1.2.0'

  # Dev Dependencies
  s.add_development_dependency 'rspec', '~> 2.0', '>= 2.0'
  s.add_development_dependency 'simplecov', '~> 0.7.1', '>= 0.7.1'
  s.add_development_dependency 'vcr', '~> 2.2.5', '>= 2.2.5'
  s.add_development_dependency 'webmock', '~> 1.8.11', '>= 1.8.11'
end
