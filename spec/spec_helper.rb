require 'simplecov'
SimpleCov.start do
  add_filter '/spec/'
end

project_root = File.expand_path(File.dirname(__FILE__) + "/..")
$LOAD_PATH << "#{project_root}/lib"

require 'rubygems'
require 'circleci'
require 'vcr'
require 'pry'

require 'dotenv'
Dotenv.load

Dir[("#{project_root}/spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  config.before do
    CircleCi.configure do |c|
      c.token = ENV['TOKEN']
    end
  end

end

VCR.configure do |config|
  config.hook_into :webmock, :typhoeus
  config.cassette_library_dir     = 'spec/cassettes'
  config.ignore_localhost         = true
  config.default_cassette_options = { :record => :new_episodes }

  config.filter_sensitive_data('asdf-token') { ENV['TOKEN'] }
  config.filter_sensitive_data('orga-name') { ENV['ORGANIZATION'] }
  config.configure_rspec_metadata!
end
