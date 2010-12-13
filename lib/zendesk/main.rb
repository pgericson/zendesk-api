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


    def params_list(list)
      params = "?" + list.map do |k, v|
        if v.is_a?(Array)
          v.map do |val|
            "#{k}[]=#{val}"
          end.join("&")
        else
          "#{k}=#{v}"
        end
      end.join("&")
    end
    
    def string_body(body)
      if body.values.first.is_a?(Hash)
        body.values.first.to_xml.strip
      elsif body.values.first.is_a?(String)
        body.values.first
      end
    end

    def make_request(end_url, body = {})
      curl = Curl::Easy.new(main_url + end_url + ".#{@format}")
      curl.userpwd = "#{@username}:#{@password}"
      if body.empty? or body[:list]
        curl.url = curl.url + params_list(body[:list]) if body[:list]
        curl.perform
      elsif body[:post]
        curl.headers = "Content-Type: application/xml"
        curl.http_post 
      elsif body[:create]
        curl.headers = "Content-Type: application/xml"
        curl.http_post(string_body(body))
      elsif body[:update]
        # PUT seems badly broken, at least I can't get it to work without always
        # raising an exception about rewinding the data stream
        # curl.http_put(final_body)
        curl.headers = { "Content-Type" => "application/xml", "X-Http-Method-Override" => "put" }    
        curl.http_post(string_body(body))
      elsif body[:destroy]
        curl.http_delete
      end

      if curl.body_str == "<error>Couldn't authenticate you</error>"
        return "string" #raise CouldNotAuthenticateYou 
      end
      Response.new(curl, format)
    end

    class Response

      attr_reader :status, :body, :headers_raw, :headers, :curl, :url, :data

      def initialize(curl, format)
        @format=format
        @curl = curl
        @url = curl.url
        @status = curl.response_code
        @body = curl.body_str
        @headers_raw = curl.header_str
        parse_headers
        # parse the data coming back
        @data = Crack::XML.parse(@body || "") if @format == "xml"
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
    include Zendesk::UserIdentity
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
