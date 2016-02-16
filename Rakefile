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

desc 'Run specs'
RSpec::Core::RakeTask.new('spec') do |task|
  task.pattern = 'spec/**/*_spec.rb'
end

YARD::Rake::YardocTask.new(:doc) do |task|
  task.files   = %w[lib/**/*.rb - README.md]
  task.options = %w[no-private]
end
