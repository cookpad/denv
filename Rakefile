require "bundler/gem_tasks"
task :default => :test

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
rescue LoadError
end

desc 'Run all tests'
task :test do
  Rake::Task[:spec].invoke
  Rake::Task[:integration_test].invoke
end

desc 'Run Rails integration test'
task :integration_test do
  exit(1) unless execute_without_bundler { ruby('rails_integration_test.rb') }
end

def execute_without_bundler
  defined?(Bundler) ? Bundler.with_clean_env { yield } : yield
end
