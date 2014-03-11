require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.pattern = "test/**/*_test.rb"
end

Rake::TestTask.new(:examples) do |t|
  t.pattern = "examples/**/*_example.rb"
end

task :default => [:test, :examples]
