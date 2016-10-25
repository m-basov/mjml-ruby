require 'rake'
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'lib'
  t.pattern = 'spec/**/*_spec.rb'
  t.verbose = true
  t.warning = true
end

task default: :test

TEMPLATE_PATH = "#{Dir.pwd}/spec/fixtures"
OUTPUT_FILES = ['hello.html', 'hello.min.html']

# Prepare env for tests
task :prepare => [:clear] do
  `mjml #{TEMPLATE_PATH}/hello.mjml -o #{TEMPLATE_PATH}/hello.html`
  `mjml #{TEMPLATE_PATH}/hello.mjml -o #{TEMPLATE_PATH}/hello.min.html --min`
end

task :clear do
  OUTPUT_FILES.each do |file|
    file_path = "#{TEMPLATE_PATH}/#{file}"
    File.delete(file_path) if File.exist?(file_path)
  end
end
