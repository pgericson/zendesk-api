require 'rubygems'
require 'rake'
require 'echoe'

Echo.new('uniquify', '0.1.2') do |p|
  p.description     = "RubyGem wrapper for REST API to http://zendesk.com"
  p.author          = "Peter Ericson"
  p.url             = "http://github.com/pgericson/zendesk-api"
  p.email           = "pg.ericson@gmail.com"
  p.ignore_pattern  = ["tmp/*", "script/*"]
  p.development_dependencies = []
end


Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }
