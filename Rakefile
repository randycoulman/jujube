require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.pattern = "test/**/*_test.rb"
end

Rake::TestTask.new(:acceptance) do |t|
  t.pattern = "acceptance/**/*_example.rb"
end

task :default => [:test, :acceptance]
