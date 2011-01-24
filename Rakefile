require 'bundler'
Bundler.setup

require 'rspec/core/rake_task'
require 'cucumber/rake/task'

desc "Run specs"
RSpec::Core::RakeTask.new do |t|
  t.rspec_opts = %w(--format=progress --color)
end

Cucumber::Rake::Task.new(:cucumber) do |t|
  t.cucumber_opts = %w{--format progress}
end

task :default => [:spec, :cucumber]

task :glider do
  system('./bin/conway -S --cells="10,2 9,3 8,3 9,4 10,4"')
end
