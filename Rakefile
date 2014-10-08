require 'rake'
require 'rake/clean'
require 'rake/testtask'

CLEAN.include("**/*.gem", "**/*.rbc", "**/*.rbx")

namespace :gem do
  desc 'Build the union gem'
  task :create => [:clean] do
    spec = eval(IO.read('union.gemspec'))
    if Gem::VERSION.to_f < 2.0
      Gem::Builder.new(spec).build
    else
      require 'rubygems/package'
      Gem::Package.build(spec)
    end
  end

  task :install => [:create] do
    file = Dir["*.gem"].first
    sh "gem install -l #{file}"
  end
end

Rake::TestTask.new do |t|
  t.verbose = true
  t.warning = true
end

task :default => :test
