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
  s.add_dependency 'hashie',      '~> 2.1.0', '>= 2.1.0'
  s.add_dependency 'rest-client', '~> 1.6.7', '>= 1.6.7'

  # Dev Dependencies
  s.add_development_dependency 'coveralls', '~> 0.7.0',  '>= 0.7.0'
  s.add_development_dependency 'dotenv',    '~> 0.10.0', '>= 0.10.0'
  s.add_development_dependency 'gemcutter', '~> 0.7.1',  '>= 0.7.1'
  s.add_development_dependency 'pry',       '~> 0.9.12', '>= 0.9.12.6'
  s.add_development_dependency 'rake',      '~> 10.1.0', '>= 10.1.0'
  s.add_development_dependency 'redcarpet', '~> 3.1.0',  '>= 3.1.0'
  s.add_development_dependency 'rspec',     '~> 2.14.1', '>= 2.14.1'
  s.add_development_dependency 'simplecov', '~> 0.8.2',  '>= 0.8.2'
  s.add_development_dependency 'typhoeus',  '~> 0.6.8',  '>= 0.6.8'
  s.add_development_dependency 'vcr',       '~> 2.9.0',  '>= 2.9.0'
  s.add_development_dependency 'webmock',   '~> 1.17.4', '>= 1.17.4'
  s.add_development_dependency 'yard',      '~> 0.8.7',  '>= 0.8.7.4'
end
