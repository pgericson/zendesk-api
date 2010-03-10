require 'rubygems'
require 'curb'
require 'activeresource'

module Zendesk
  class Error < StandardError; end
  class Main
    attr_accessor :main_url, :format
    attr_reader :response_raw, :response

    def initialize(account, username, password, options = {})
      @account = account
      @username = username
      @password = password
      puts
      if options[:format] && ['xml','json'].any?{|f| f == options[:format]}
        @format = options[:format]
      else
        @format = 'xml'
      end
    end
  
    def main_url
      url_prefix    = "http://"
      url_postfix   = ".zendesk.com/"
      url = url_prefix + @account + url_postfix
    end

    private
      def make_request(end_url, body = {})
        curl = Curl::Easy.new(main_url + end_url + ".#{@format}")
        curl.userpwd = "#{@username}:#{@password}"
        unless body.empty?
          if body[:create]
            curl.headers = "Content-Type: application/xml"
            curl.http_post(options[:create])
          elsif body[:update]
            curl.headers = "Content-Type: application/xml"
            curl.http_put(options[:update])
          elsif body[:destroy]
            curl.http_delete(options[:destroy])
          end
        else
          curl.perform
        end

        if curl.body_str == "<error>Couldn't authenticate you</error>"
          return CouldNotAuthenticateYou
        end
        curl.body_str
      end
  end

  class Ticket < Main
    attr_reader :url_function
    
    def url_function
      self.to_s + 's'
    end

    def get_all_tickets
      make_request("#{url_function}")
    end

    def get_ticket(id)
      make_request("#{url_function}/#{id}")
    end

    def create_ticket(hash)
      make_request("#{url_function}", :create => hash)
    end

    def update_ticket(hash)
      make_request("#{url_function}", :update => hash)
    end

    def delete_ticket(id)
      make_request("#{url_function}", :destroy => true)
    end

  end
end
