# -*- encoding: utf-8 -*-
Gem::Specification.new do |spec|
  spec.name = 'user_email_address_component'
  spec.version = '0.0.0'
  spec.summary = 'User Email Address Component'
  spec.description = ' '

  spec.authors = ['Joseph Choe']
  spec.email = ['joseph@josephchoe.com']
  spec.homepage = 'https://github.com/bluepuppetcompany/user-email-address-component'

  spec.require_paths = ['lib']
  spec.files = Dir.glob('{lib}/**/*')
  spec.platform = Gem::Platform::RUBY
  spec.required_ruby_version = '>= 2.6'

  spec.add_runtime_dependency 'eventide-postgres'
  spec.add_runtime_dependency 'evt-try'

  spec.add_development_dependency 'test_bench'
end
