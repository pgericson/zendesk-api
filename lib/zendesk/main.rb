module Zendesk
  class Main
    attr_accessor :main_url, :format
    attr_reader :response_raw, :response

    def initialize(account, username, password, options = {})
      @account = account
      @username = username
      @password = password
      @options = options
      if options[:format] && ['xml', 'json'].any?{|f| f == options[:format]}
        @format = options[:format]
      else
        @format = 'xml'
      end
    end

    def main_url
      url_prefix    = @options[:ssl] ? "https://" : "http://"
      url_postfix   = ".zendesk.com/"
      url = url_prefix + @account + url_postfix
    end

    def self.to_xml(function_name, input)
      if input.is_a?(String)
        input
      else
        input.to_xml({:root => function_name})
      end
    end

    def make_request(end_url, body = {})
      curl = Curl::Easy.new(main_url + end_url + ".#{@format}")
      curl.userpwd = "#{@username}:#{@password}"
      unless body.empty?
        if body[:list]
          params = "?" + body[:list].map do |k, v|
            if v.is_a?(Array)
              v.map do |val|
                "#{k}[]=#{val}"
              end.join("&")
            else
              "#{k}=#{v}"
            end
          end.join("&")
          curl.url = curl.url + params
        else
          if body.values.first.is_a?(Hash)
            final_body = body.values.first.to_xml
          elsif body.values.first.is_a?(String)
            final_body = body.values.first
          end

          if body[:create]
            curl.headers = "Content-Type: application/xml"
            curl.http_post(final_body)
          elsif body[:update]
            curl.headers = "Content-Type: application/xml"
            curl.http_put(final_body)
          elsif body[:destroy]
            curl.http_delete
          end
        end
      end
      curl.perform

      if curl.body_str == "<error>Couldn't authenticate you</error>"
        return "string" #raise CouldNotAuthenticateYou 
      end
      Response.new(curl)
    end

    class Response

      attr_reader :status, :body, :headers_raw, :headers, :curl

      def initialize(curl)
        @curl = curl
        @status=curl.response_code
        @body=curl.body_str
        @headers_raw=curl.header_str
        parse_headers
      end

      def parse_headers
        hs={}
        return hs if headers_raw.nil? or headers_raw==""
        headers_raw.split("\r\n")[1..-1].each do |h|
#          Rails.logger.info h
          m=h.match(/([^:]+):\s?(.*)/)
          next if m.nil? or m[2].nil?
#          Rails.logger.info m.inspect
          hs[m[1]]=m[2]
        end
        @headers=hs
      end

    end

    include Zendesk::User
    include Zendesk::Organization
    include Zendesk::Group
    include Zendesk::Ticket
    include Zendesk::Attachment
    include Zendesk::Tag
    include Zendesk::Forum
    include Zendesk::Entry
    include Zendesk::Search
  end
end
