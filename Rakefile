require 'rake/rdoctask'
require File.expand_path('../lib/panda_canvas/version', __FILE__)

Rake::RDocTask.new do |rd|
  rd.main = 'README.rdoc'
  rd.options << '--all'
  rd.rdoc_dir = 'docs'
  rd.rdoc_files.include 'README.rdoc', 'LICENSE', File.join('lib', '**', '*.rb')
  rd.title = 'Panda Canvas Documentation'
end

desc 'Build gem from current sources'
task :build do
  system 'gem build panda_canvas.gemspec'
end

desc 'Build gem from current sources and push to RubyGems.org'
task :release => :build do
  system "gem push panda_canvas-#{::PandaCanvas::VERSION}.gem"
end

desc 'Build RDoc, and build gem'
task :all => [:rdoc, :build]

task :default => :all