require 'rubygems'
require 'curb'
require 'activeresource'

module Zendesk
  class Error < StandardError; end
  class CouldNotAuthenticateYou < StandardError; end
end

require 'zendesk/ticket'
require 'zendesk/user'
require 'zendesk/organization'
require 'zendesk/group'
require 'zendesk/attachment'
require 'zendesk/main'
