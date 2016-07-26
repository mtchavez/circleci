# frozen_string_literal: true
require 'simplecov'
require 'coveralls'

SimpleCov.formatter = Coveralls::SimpleCov::Formatter
SimpleCov.start do
  add_filter '/spec/'
  add_filter 'vendor'
end

project_root = File.expand_path(File.dirname(__FILE__) + '/..')
$LOAD_PATH << "#{project_root}/lib"

require 'rubygems'
require 'circleci'
require 'vcr'
require 'pry'

require 'dotenv'
Dotenv.load

Dir["#{project_root}/spec/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.filter_run :focus
  config.run_all_when_everything_filtered = true
  config.disable_monkey_patching!
  config.warnings = true
  config.profile_examples = 10

  config.before do
    CircleCi.configure do |c|
      c.token = ENV['TOKEN']
      c.request_overrides = {
        verify_ssl: false
      }
    end
  end
end

VCR.configure do |config|
  config.hook_into :webmock, :typhoeus
  config.cassette_library_dir     = 'spec/cassettes'
  config.ignore_localhost         = true
  config.default_cassette_options = { record: :new_episodes }

  config.filter_sensitive_data('<TOKEN>') { ENV['TOKEN'] }
  config.filter_sensitive_data('<ORG_NAME>') { ENV['ORGANIZATION'] }
  config.filter_sensitive_data('<HEROKU_TOKEN>') { ENV['HEROKU_TOKEN'] }
  config.configure_rspec_metadata!
end
