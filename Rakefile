require "bundler/gem_tasks"
require "rake/testtask"
require "yard"

task :default => [:test, :acceptance]

Rake::TestTask.new(:test) do |t|
  t.pattern = "test/**/*_test.rb"
end

Rake::TestTask.new(:acceptance) do |t|
  t.pattern = "acceptance/**/*_test.rb"
end

YARD::Rake::YardocTask.new
