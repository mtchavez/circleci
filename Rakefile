# frozen_string_literal: true

require 'rubygems'
require 'bundler'
require 'yard'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

Bundler::GemHelper.install_tasks

task test: %i[rubocop spec]
task default: :test

# Rubocop
desc 'Run Rubocop lint checks'
task :rubocop do
  RuboCop::RakeTask.new
end

desc 'Gem checksum'
task :checksum do
  gem_name = ENV.fetch('GEM_NAME', nil)
  break unless gem_name

  require 'digest/sha2'
  cur_dir = __dir__
  built_gem_path = File.join(cur_dir, "pkg/#{gem_name}.gem")
  checksum = Digest::SHA512.new.hexdigest(File.read(built_gem_path))
  checksum_path = File.join(cur_dir, "checksum/#{gem_name}.gem.sha512")
  File.open(checksum_path, 'w') { |f| f.write(checksum) }
  puts "Wrote #{checksum_path}"
end

desc 'Run specs'
RSpec::Core::RakeTask.new('spec') do |task|
  task.pattern = 'spec/**/*_spec.rb'
end

YARD::Rake::YardocTask.new(:doc) do |task|
  task.files   = %w[lib/**/*.rb - README.md]
  task.options = %w[no-private]
end
