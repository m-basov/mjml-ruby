# encoding: utf-8

$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'mjml/version'

Gem::Specification.new do |s|
  s.name                 = 'mjml-ruby'
  s.version              = MJML::VERSION
  s.authors              = ['Mykola Basov']
  s.email                = ['kolybasov@gmail.com']
  s.homepage             = 'https://github.com/kolybasov/mjml-ruby'
  s.summary              = 'MJML parser and template engine for Ruby'
  s.license              = 'MIT'
  s.post_install_message = 'Don\'t forget to run $ npm install -g mjml@^3.0'

  s.files                = `git ls-files app lib`.split("\n")
  s.test_files           = s.files.grep(%r{^(test|spec|features)/})
  s.platform             = Gem::Platform::RUBY
  s.require_paths        = ['lib']

  s.add_development_dependency 'rake'
  s.add_development_dependency 'railties','~> 6'
  s.add_development_dependency 'actionmailer', '~> 6'
  s.add_development_dependency 'tzinfo-data'
  s.add_development_dependency 'minitest', '~> 5.9', '>= 5.0'
  s.add_development_dependency 'tilt', '~> 2.0', '>= 2.0'
  s.add_development_dependency 'sprockets', '~> 3.7', '>= 3.0'
  s.add_development_dependency 'byebug', '~> 9.0', '>= 9.0'
end
