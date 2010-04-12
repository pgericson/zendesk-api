require "spec"
require 'zendesk-api'

describe Zendesk::Main do
  before do
    curl_object = Curl::Easy.method(:new)
    Curl::Easy.stub!(:new).and_return do |*args|
      curl = curl_object.call(*args)
      curl.stub!(:perform)
      curl.stub!(:header_str) { "adsf\r\ndsaf"}
      curl
    end
  end

  it "should construct array url for search" do
    zendesk = Zendesk::Main.new('my_company', "some_login", "some_password")
    params = {
            :foo => "bar",
            :foo_list => [1, 2, 3]
    }

    response = zendesk.make_request("search", :list => params)
    response.curl.url.should =~ /foo=bar/
    response.curl.url.should =~ /foo_list\[\]=1/
    response.curl.url.should =~ /foo_list\[\]=2/
    response.curl.url.should =~ /foo_list\[\]=3/

  end
end