require File.expand_path('../lib/panda_canvas/version', __FILE__)
require 'yard'

YARD::Rake::YardocTask.new

desc 'Build gem from current sources'
task :build do
  system 'gem build panda_canvas.gemspec'
end

desc 'Build gem from current sources and push to RubyGems.org'
task :release => :build do
  system "gem push panda_canvas-#{::PandaCanvas::Version}.gem"
end

desc 'Generate docs and build gem'
task :all => [:yard, :build]

task :default => :all
