Gem::Specification.new do |s|
  s.name             = 'circleci'
  s.version          = '0.0.7'
  s.date             = '2014-06-08'
  s.summary          = 'Circle CI API Wrapper'
  s.description      = 'Wraps Circle CI API calls in a gem.'
  s.licenses         = ['MIT']
  s.authors          = ['Chavez']
  s.email            = 'nailsbrokeandfell@gmail.com'
  s.files            = Dir.glob('{bin,lib}/**/*') + %w(README.md)
  s.require_paths    = ['lib']
  s.homepage         = 'http://github.com/mtchavez/circleci'
  s.rdoc_options     = ['--charset=UTF-8 --main=README.md']
  s.extra_rdoc_files = ['README.md']

  # Gem Dependencies
  s.add_dependency 'hashie',      '~> 3.3.1', '>= 3.3.1'
  s.add_dependency 'rest-client', '~> 1.7.2', '>= 1.7.2'

  # Dev Dependencies
  s.add_development_dependency 'coveralls', '~> 0.7.1',  '>= 0.7.1'
  s.add_development_dependency 'dotenv',    '~> 1.0.2',  '>= 1.0.2'
  s.add_development_dependency 'gemcutter', '~> 0.7.1',  '>= 0.7.1'
  s.add_development_dependency 'pry',       '~> 0.10.1', '>= 0.10.1'
  s.add_development_dependency 'rake',      '~> 10.3.2', '>= 10.3.2'
  s.add_development_dependency 'redcarpet', '~> 3.2.0',  '>= 3.2.0'
  s.add_development_dependency 'rspec',     '~> 2.14.1', '>= 2.14.1'
  s.add_development_dependency 'simplecov', '~> 0.9.1',  '>= 0.9.1'
  s.add_development_dependency 'typhoeus',  '~> 0.6.9',  '>= 0.6.9'
  s.add_development_dependency 'vcr',       '~> 2.9.3',  '>= 2.9.3'
  s.add_development_dependency 'webmock',   '~> 1.17.4', '>= 1.17.4'
  s.add_development_dependency 'yard',      '~> 0.8.7',  '>= 0.8.7.6'
end
