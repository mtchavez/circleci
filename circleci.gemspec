# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name                  = 'circleci'
  s.version               = '2.0.2'
  s.date                  = '2018-01-28'
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
  s.required_ruby_version = '>= 2.0.0' # rubocop:disable Gemspec/RequiredRubyVersion
  s.cert_chain            = %w[certs/mtchavez.pem]
  s.signing_key           = File.join(Gem.user_home, '.ssh', 'gem-private_key.pem') if $PROGRAM_NAME.end_with?('gem')

  # Dev Dependencies
  s.add_development_dependency 'dotenv',     '~> 2.7.1'
  s.add_development_dependency 'gemcutter',  '~> 0.7.1'
  s.add_development_dependency 'multi_json', '~> 1.13.1'
  s.add_development_dependency 'pry',        '~> 0.12.0'
  s.add_development_dependency 'pry-byebug', '~> 3.7.0'
  s.add_development_dependency 'pry-doc',    '~> 1.0.0'
  s.add_development_dependency 'rake',       '~> 12.3.1'
  s.add_development_dependency 'redcarpet',  '~> 3.4.0'
  s.add_development_dependency 'rspec',      '~> 3.8.0'
  s.add_development_dependency 'rubocop',    '~> 0.70.0'
  s.add_development_dependency 'simplecov',  '~> 0.16.1'
  s.add_development_dependency 'typhoeus',   '~> 1.3.0'
  s.add_development_dependency 'vcr',        '~> 4.0.0'
  s.add_development_dependency 'webmock',    '~> 3.5.1'
  s.add_development_dependency 'yard',       '~> 0.9.11'
end
