require 'rubygems'

Gem::Specification.new do |gem|
  gem.name       = 'union'
  gem.version    = '1.0.5'
  gem.author     = 'Daniel J. Berger'
  gem.license    = 'Artistic 2.0'
  gem.email      = 'djberg96@gmail.com'
  gem.homepage   = 'https://github.com/djberg96/union'
  gem.summary    = 'A struct-like C union for Ruby'
  gem.test_file  = 'test/test_union.rb'
  gem.files      = Dir['**/*'].reject{ |f| f.include?('git') }
  gem.cert_chain = Dir['certs/*']

  gem.extra_rdoc_files = ['README', 'CHANGES', 'MANIFEST']
  gem.add_development_dependency('rake')

  gem.description = <<-EOF
    The union library provides an analog to a C/C++ union for Ruby.
    In this implementation a union is a kind of struct where multiple
    members may be defined, but only one member ever contains a non-nil
    value at any given time.
  EOF
end
