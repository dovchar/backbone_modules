#!/usr/bin/env rake
require "bundler/gem_tasks"
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'lib/backbone_modules'
  t.test_files = FileList['test/lib/backbone_modules/*_test.rb']
  t.verbose = true
end
task :default => :test