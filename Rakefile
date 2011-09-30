require 'rake'
require 'rake/clean'
require 'rake/testtask'

CLEAN.include("**/*.gem", "**/*.rbc", ".rbx")

namespace :gem do
  desc 'Build the union gem'
  task :create do
    spec = eval(IO.read('union.gemspec'))
    Gem::Builder.new(spec).build
  end

  task :install => [:create] do
    file = Dir["*.gem"].first
    sh "gem install #{file}"
  end
end

Rake::TestTask.new do |t|
  t.verbose = true
  t.warning = true
end

task :default => :test
