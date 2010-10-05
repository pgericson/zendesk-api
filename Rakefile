require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('zendesk-api', '0.3.1') do |p|
  p.description     = "RubyGem wrapper for REST API to http://zendesk.com"
  p.author          = "Peter Ericson"
  p.url             = "http://github.com/pgericson/zendesk-api"
  p.email           = "pg.ericson@gmail.com"
  p.ignore_pattern  = ["tmp/*", "script/*"]
  p.development_dependencies = []
end
# how to build the new gem ( I can't remember so here it is for all time)
# rake build_gemspec

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }
