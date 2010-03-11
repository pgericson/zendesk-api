require 'rubygems'
require 'curb'
require 'activeresource'

module Zendesk
  class Error < StandardError; end
  class CouldNotAuthenticateYou < StandardError; end
end
require 'lib/zendesk/ticket'
require 'lib/zendesk/user'
require 'lib/zendesk/organization'
require 'lib/zendesk/main'
