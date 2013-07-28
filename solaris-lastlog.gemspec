Gem::Specification.new do |s|
  s.add_dependency( 'bindata', '>= 1.5.0' )
  s.authors = [ 'Martin Carpenter' ]
  s.date = Time.now.strftime('%Y-%m-%d')
  s.description = 'Read and write Solaris lastlog files'
  s.email = 'mcarpenter@free.fr'
  s.extra_rdoc_files = %w{ LICENSE Rakefile README.rdoc }
  s.files = FileList[ 'examples/**/*', 'lib/**/*', 'test/**/*' ].to_a
  s.has_rdoc = true
  s.homepage = 'http://github.com/mcarpenter/solaris-lastlog'
  s.licenses = [ 'BSD' ]
  s.name = 'solaris-lastlog'
  s.platform = Gem::Platform::RUBY
  s.require_path = 'lib'
  s.rubyforge_project = nil
  s.summary = s.description
  s.test_files = FileList[ "{test}/**/test_*.rb" ].to_a
  s.version = '1.0.0'
end

