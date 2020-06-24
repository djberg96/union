require 'rubygems'

Gem::Specification.new do |spec|
  spec.name       = 'union'
  spec.version    = '1.1.0'
  spec.author     = 'Daniel J. Berger'
  spec.license    = 'Apache-2.0'
  spec.email      = 'djberg96@gmail.com'
  spec.homepage   = 'https://github.com/djberg96/union'
  spec.summary    = 'A struct-like C union for Ruby'
  spec.test_file  = 'test/test_union.rb'
  spec.files      = Dir['**/*'].reject{ |f| f.include?('git') }
  spec.cert_chain = Dir['certs/*']

  spec.extra_rdoc_files = ['README', 'CHANGES', 'MANIFEST']
  spec.add_development_dependency('rake')

  spec.metadata = {
    'homepage_uri'      => 'https://github.com/djberg96/union',
    'bug_tracker_uri'   => 'https://github.com/djberg96/union/issues',
    'changelog_uri'     => 'https://github.com/djberg96/union/blob/master/CHANGES',
    'documentation_uri' => 'https://github.com/djberg96/union/wiki',
    'source_code_uri'   => 'https://github.com/djberg96/union',
    'wiki_uri'          => 'https://github.com/djberg96/union/wiki'
  }

  spec.description = <<-EOF
    The union library provides an analog to a C/C++ union for Ruby.
    In this implementation a union is a kind of struct where multiple
    members may be defined, but only one member ever contains a non-nil
    value at any given time.
  EOF
end
