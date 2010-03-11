module Zendesk
  class Main
    attr_accessor :main_url, :format
    attr_reader :response_raw, :response

    def initialize(account, username, password, options = {})
      @account = account
      @username = username
      @password = password
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
          curl.http_delete(final_body)
        elsif body[:list]
          params = "?" + body[:list].to_a.map do |p|
            "#{p[0]}=#{p[1]}"
          end.join("&")
          curl.url = curl.url + params
        end
      else
        curl.perform
      end

      if curl.body_str == "<error>Couldn't authenticate you</error>"
        return "string" #raise CouldNotAuthenticateYou 
      end
      curl.body_str
    end
  end
end
