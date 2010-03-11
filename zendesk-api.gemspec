require 'rubygems'
require 'rake'

Gem::Specification.new do |s|
  s.name = "zendesk-api"
  s.version = "0.1.2"
 
  s.authors = ["Peter Ericson"]
  s.date = "2010-03-11"
  s.description = "RubyGem wrapper for REST API to http://zendesk.com"
  s.email = ["pg.ericson@gmail.com"]
  s.files = FileList["[A-Z]*", "lib/**/*.rb"]
  s.has_rdoc = false
  s.homepage = %q{http://github.com/pgericson/zendesk-api}
  #s.rdoc_options = ["--main", "README.markdown"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{zendesk-api}
  s.rubygems_version = %q{1.3.6}
  s.summary = "RubyGem wrapper for REST API to http://zendesk.com"

  s.add_dependency "curb", ">= 0.6.4"
end
