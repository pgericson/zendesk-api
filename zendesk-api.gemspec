Gem::Specification.new do |s|
  s.name = %q{zendesk-api}
  s.version = "0.1.2"
 
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Peter Ericson"]
  s.date = %q{2010-03-11}
  s.description = %q{RubyGem wrapper for REST API to http://zendesk.com}
  s.email = ["pg.ericson@gmail.com"]
  s.files = ["README.markdown", "lib/zendesk.rb", "lib/zendesk/console.rb", ]
  s.files = FileList["[A-Z]*", "lib/**/*.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/pgericson/zendesk-api http://www.zendesk.com/api}
  s.rdoc_options = ["--main", "README.markdown"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{zendesk-api}
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{RubyGem wrapper for REST API to http://zendesk.com}
end
