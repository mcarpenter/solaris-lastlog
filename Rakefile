require 'rake'
require 'rake/clean'
require 'rake/testtask'
require 'rdoc/task'
require 'rubygems/package_task'

desc 'Default task (package)'
task :default => [:package]

Rake::TestTask.new( 'test' )

SPECFILE = 'solaris-lastlog.gemspec'
if File.exist?( SPECFILE )
  spec = eval( File.read( SPECFILE ) )
  Gem::PackageTask.new( spec ).define
end

RDoc::Task.new do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = 'solaris-lastlog'
  rdoc.options << '--charset' << 'utf-8'
  rdoc.options << '--main' << 'README.rdoc'
  rdoc.options << '--all'
  rdoc.rdoc_files.include( 'README.rdoc' )
  rdoc.rdoc_files.include( FileList[ 'lib/**/*.rb' ] )
  rdoc.rdoc_files.include( FileList[ 'test/*.rb' ] )
end

