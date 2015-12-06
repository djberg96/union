require 'rake'
require 'rake/clean'
require 'rake/testtask'

CLEAN.include("**/*.gem", "**/*.rbc", "**/*.rbx")

namespace :gem do
  desc 'Build the union gem'
  task :create => [:clean] do
    require 'rubygems/package'
    spec = eval(IO.read('union.gemspec'))
    spec.signing_key = File.join(Dir.home, '.ssh', 'gem-private_key.pem')
    Gem::Package.build(spec, true)
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
