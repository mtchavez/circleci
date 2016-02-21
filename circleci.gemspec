Gem::Specification.new do |s|
  s.name             = 'circleci'
  s.version          = '0.2.0'
  s.date             = '2015-12-06'
  s.summary          = 'Circle CI REST API gem'
  s.description      = 'Ruby gem for Circle CI REST API'
  s.licenses         = %w[MIT]
  s.authors          = %w[Chavez]
  s.email            = 'chavez@example.com'
  s.files            = Dir.glob('{bin,lib}/**/*') + %w[README.md]
  s.require_paths    = %w[lib]
  s.homepage         = 'http://github.com/mtchavez/circleci'
  s.rdoc_options     = %w[--charset=UTF-8 --main=README.md]
  s.extra_rdoc_files = %w[README.md]

  # Gem Dependencies
  s.add_dependency 'rest-client', '~> 1.8'

  # Dev Dependencies
  s.add_development_dependency 'coveralls',     '~> 0.8.11'
  s.add_development_dependency 'dotenv',        '~> 2.1.0'
  s.add_development_dependency 'gemcutter',     '~> 0.7.1'
  s.add_development_dependency 'multi_json',    '~> 1.11.2'
  s.add_development_dependency 'pry',           '~> 0.10.3'
  s.add_development_dependency 'rake',          '~> 10.5.0'
  s.add_development_dependency 'redcarpet',     '~> 3.3.4'
  s.add_development_dependency 'rspec',         '~> 2.14.1', '>= 2.14.1'
  s.add_development_dependency 'rubocop',       '~> 0.37.2'
  s.add_development_dependency 'simplecov',     '~> 0.11.2'
  s.add_development_dependency 'typhoeus',      '~> 1.0.1'
  s.add_development_dependency 'vcr',           '~> 3.0.1'
  s.add_development_dependency 'webmock',       '~> 1.24.0'
  s.add_development_dependency 'yard',          '~> 0.8.7'
end
