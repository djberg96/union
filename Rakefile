require 'rake'
require 'rake/testtask'
require 'rbconfig'
include Config

desc 'Install the union library (non-gem)'
task :install do
   sitelibdir = CONFIG["sitelibdir"]
   file = "lib/union.rb"
   FileUtils.cp(file, sitelibdir, :verbose => true)
end

desc 'Build the union gem'
task :gem do
   spec = eval(IO.read('union.gemspec'))
   Gem::Builder.new(spec).build
end

task :install_gem => [:gem] do
   file = Dir["*.gem"].first
   sh "gem install #{file}"
end

Rake::TestTask.new do |t|
   t.verbose = true
   t.warning = true
end
