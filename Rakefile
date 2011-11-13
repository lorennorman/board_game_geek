### Gem Development/Management
require 'bundler'
Bundler::GemHelper.install_tasks


### Spec Runner
require 'rake/testtask'
Rake::TestTask.new :spec do |t|
  t.libs << "spec"
  t.pattern = "spec/*_spec.rb"
  t.verbose = true
end

task :default => :spec