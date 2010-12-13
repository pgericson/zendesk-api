require 'rubygems'
require 'curb'
require 'crack'
require 'active_resource'

module Zendesk
  class Error < StandardError; end
  class CouldNotAuthenticateYou < StandardError; end
end

require 'zendesk/user'
require 'zendesk/user_identity'
require 'zendesk/organization'
require 'zendesk/group'
require 'zendesk/ticket'
require 'zendesk/attachment'
require 'zendesk/tag'
require 'zendesk/forum'
require 'zendesk/entry'
require 'zendesk/search'
require 'zendesk/main'
