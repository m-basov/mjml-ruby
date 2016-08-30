# encoding: utf-8

$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'mjml/version'

Gem::Specification.new do |s|
  s.name                 = 'mjml-ruby'
  s.version              = Mjml::VERSION
  s.authors              = ['Mykola Basov']
  s.email                = ['kolybasov@gmail.com']
  s.homepage             = 'https://github.com/kolybasov/mjml-ruby'
  s.summary              = 'MJML parser and template engine for Ruby'
  s.post_install_message = 'Don\'t forget to run $ npm install -g mjml@^2.0'

  s.files                = `git ls-files app lib`.split("\n")
  s.test_files           = s.files.grep(%r{^(test|spec|features)/})
  s.platform             = Gem::Platform::RUBY
  s.require_paths        = ['lib']

  s.add_runtime_dependency 'dry-configurable', '~> 0.1.7'

  s.add_development_dependency 'minitest', '~> 5.8.4'
  s.add_development_dependency 'tilt', '~> 2.0.5'
end
