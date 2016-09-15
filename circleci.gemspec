# frozen_string_literal: true
Gem::Specification.new do |s|
  s.name                  = 'circleci'
  s.version               = '1.0.0'
  s.date                  = '2016-08-31'
  s.summary               = 'Circle CI REST API gem'
  s.description           = 'Ruby gem for Circle CI REST API'
  s.licenses              = %w[MIT]
  s.authors               = %w[Chavez]
  s.email                 = 'contact@el-chavez.me'
  s.files                 = Dir.glob('{bin,lib}/**/*') + %w[README.md]
  s.require_paths         = %w[lib]
  s.homepage              = 'http://github.com/mtchavez/circleci'
  s.rdoc_options          = %w[--charset=UTF-8 --main=README.md]
  s.extra_rdoc_files      = %w[README.md]
  s.required_ruby_version = '>= 2.0.0'
  s.cert_chain            = %w[certs/yourhandle.pem]
  s.signing_key           = File.expand_path('$HOME/.ssh/gem-private_key.pem') if $PROGRAM_NAME.end_with?('gem')

  # Dev Dependencies
  s.add_development_dependency 'coveralls',     '~> 0.8.14', '>= 0.8.14'
  s.add_development_dependency 'dotenv',        '~> 2.1.1', '>= 2.1.1'
  s.add_development_dependency 'gemcutter',     '~> 0.7.1', '>= 0.7.1'
  s.add_development_dependency 'multi_json',    '~> 1.12.1', '>= 1.12.1'
  s.add_development_dependency 'pry',           '~> 0.10.4', '>=  0.10.4'
  s.add_development_dependency 'rake',          '~> 11.2.2', '>= 11.2.2'
  s.add_development_dependency 'redcarpet',     '~> 3.3.4', '>= 3.3.4'
  s.add_development_dependency 'rspec',         '~> 3.5.0', '>= 3.5.0'
  s.add_development_dependency 'rubocop',       '~> 0.42.0', '>= 0.42.0'
  s.add_development_dependency 'simplecov',     '~> 0.12.0', '>= 0.12.0'
  s.add_development_dependency 'typhoeus',      '~> 1.1.0', '>= 1.1.0'
  s.add_development_dependency 'vcr',           '~> 3.0.3', '>= 3.0.3'
  s.add_development_dependency 'webmock',       '~> 2.1.0', '>= 2.1.0'
  s.add_development_dependency 'yard',          '~> 0.9.5', '>= 0.9.5'
end
