require 'rake'
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'lib'
  t.pattern = 'spec/**/*_spec.rb'
  t.verbose = false
end

task default: :test

# Prepare env for tests
task :prepare do
  template_path = "#{Dir.pwd}/spec/fixtures/hello"
  system "mjml #{template_path}.mjml -o #{template_path}.html"
end
