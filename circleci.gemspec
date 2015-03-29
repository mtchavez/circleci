Gem::Specification.new do |s|
  s.name             = 'circleci'
  s.version          = '0.1.1'
  s.date             = '2015-03-29'
  s.summary          = 'Circle CI API Wrapper'
  s.description      = 'Wraps Circle CI API calls in a gem.'
  s.licenses         = ['MIT']
  s.authors          = ['Chavez']
  s.email            = 'chavez@example.com'
  s.files            = Dir.glob('{bin,lib}/**/*') + %w(README.md)
  s.require_paths    = ['lib']
  s.homepage         = 'http://github.com/mtchavez/circleci'
  s.rdoc_options     = ['--charset=UTF-8 --main=README.md']
  s.extra_rdoc_files = ['README.md']

  # Gem Dependencies
  s.add_dependency 'rest-client', '~> 1.6'

  # Dev Dependencies
  s.add_development_dependency 'coveralls', '~> 0.7.12', '>= 0.7.12'
  s.add_development_dependency 'dotenv',    '~> 2.0.0',  '>= 2.0.0'
  s.add_development_dependency 'gemcutter', '~> 0.7.1',  '>= 0.7.1'
  s.add_development_dependency 'pry',       '~> 0.10.1', '>= 0.10.1'
  s.add_development_dependency 'rake',      '~> 10.4.2', '>= 10.4.2'
  s.add_development_dependency 'redcarpet', '~> 3.2.2',  '>= 3.2.2'
  s.add_development_dependency 'rspec',     '~> 2.14.1', '>= 2.14.1'
  s.add_development_dependency 'simplecov', '~> 0.9.2',  '>= 0.9.2'
  s.add_development_dependency 'typhoeus',  '~> 0.7.1',  '>= 0.7.1'
  s.add_development_dependency 'vcr',       '~> 2.9.3',  '>= 2.9.3'
  s.add_development_dependency 'webmock',   '~> 1.21.0', '>= 1.21.0'
  s.add_development_dependency 'yard',      '~> 0.8.7',  '>= 0.8.7.6'
end
