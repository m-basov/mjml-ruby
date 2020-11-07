require 'rake'
require 'rake/testtask'
require 'bundler/gem_tasks'

Rake::TestTask.new do |t|
  t.libs << 'lib'
  t.pattern = 'spec/**/*_spec.rb'
  t.verbose = true
  t.warning = true
end

task default: [:prepare, :test]

TEMPLATE_PATH = "#{Dir.pwd}/spec/fixtures"
OUTPUT_FILES = ['hello.html', 'hello-big.html', 'hello.min.html']

def mjml_path
  local_path = File.expand_path('node_modules/.bin/mjml', Dir.pwd)
  return local_path if File.file?(local_path)
  @executable ||= `/usr/bin/env which mjml`.strip
end

# Prepare env for tests
task :prepare => [:clear] do
  `#{mjml_path} #{TEMPLATE_PATH}/hello.mjml -o #{TEMPLATE_PATH}/hello.html`
  `#{mjml_path} #{TEMPLATE_PATH}/hello-big.mjml -o #{TEMPLATE_PATH}/hello-big.html`
  `#{mjml_path} #{TEMPLATE_PATH}/hello.mjml -o #{TEMPLATE_PATH}/hello.min.html --min`
end

task :clear do
  OUTPUT_FILES.each do |file|
    file_path = "#{TEMPLATE_PATH}/#{file}"
    File.delete(file_path) if File.exist?(file_path)
  end
end
