require 'rubygems'

Gem::Specification.new do |spec|
  spec.name       = 'union'
  spec.version    = '1.3.0'
  spec.author     = 'Daniel J. Berger'
  spec.license    = 'Apache-2.0'
  spec.email      = 'djberg96@gmail.com'
  spec.homepage   = 'https://github.com/djberg96/union'
  spec.summary    = 'A struct-like C union for Ruby'
  spec.test_file  = 'spec/union_spec.rb'
  spec.files      = Dir['**/*'].reject{ |f| f.include?('git') }
  spec.cert_chain = Dir['certs/*']

  spec.add_development_dependency('rake')
  spec.add_development_dependency('rspec', '~> 3.9')
  spec.add_development_dependency('rubocop')
  spec.add_development_dependency('rubocop-rspec')

  spec.metadata = {
    'homepage_uri'          => 'https://github.com/djberg96/union',
    'bug_tracker_uri'       => 'https://github.com/djberg96/union/issues',
    'changelog_uri'         => 'https://github.com/djberg96/union/blob/main/CHANGES.md',
    'documentation_uri'     => 'https://github.com/djberg96/union/wiki',
    'source_code_uri'       => 'https://github.com/djberg96/union',
    'wiki_uri'              => 'https://github.com/djberg96/union/wiki',
    'rubygems_mfa_required' => 'true',
    'github_repo'           => 'https://github.com/djberg96/union',
    'funding_uri'           => 'https://github.com/sponsors/djberg96'
  }

  spec.description = <<-EOF
    The union library provides an analog to a C/C++ union for Ruby.
    In this implementation a union is a kind of struct where multiple
    members may be defined, but only one member ever contains a non-nil
    value at any given time.
  EOF
end
