# -*- encoding: utf-8 -*-
Gem::Specification.new do |spec|
  spec.name = 'user_email_address-client'
  spec.version = '0.0.0'
  spec.summary = 'User Email Address Client'
  spec.description = ' '

  spec.authors = ['Joseph Choe']
  spec.email = ['joseph@josephchoe.com']
  spec.homepage = 'https://github.com/bluepuppetcompany/user-email-address-component'

  spec.require_paths = ['lib']
  spec.platform = Gem::Platform::RUBY
  spec.required_ruby_version = '>= 2.6'

  files = Dir['lib/user_email_address/**/*.rb']

  files += Dir['lib/user_email_address_component/{controls.rb,controls/**/*.rb}']

  files << 'lib/user_email_address_component/load.rb'

  File.read('lib/user_email_address_component/load.rb').each_line.map do |line|
    next if line == "\n"

    _, filename = line.split(/[[:blank:]]+/, 2)

    filename.gsub!(/['"]/, '')
    filename.strip!

    filename = File.join('lib', "#{filename}.rb")

    files << filename if File.exist?(filename)
  end

  spec.files = files

  spec.add_runtime_dependency 'evt-messaging-postgres'

  spec.add_development_dependency 'test_bench'
end
