require 'rubygems'
require 'curb'
require 'crack'
gem 'activesupport'
require 'active_support'
require 'active_support/version'
# need to pull in the pieces we want with Rails 3
require 'active_support/core_ext' if ActiveSupport::VERSION::MAJOR == 3

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
