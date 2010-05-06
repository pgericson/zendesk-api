require "spec"
require 'lib/zendesk-api'

describe Zendesk::Main, "basic" do
  before(:each) do
    @account = "this_account"
    @username = "this_username"
    @password = "this_password"
    @zendesk = Zendesk::Main.new(@account, @username, @password)
  end

  it "should have the correct mail_url with no ssl options" do
    @zendesk.main_url.should == "http://#{@account}.zendesk.com/"
  end

  it "should have the correct mail_url with ssl options" do
    @zendesk = Zendesk::Main.new(@account, @username, @password, :ssl => true)
    @zendesk.main_url.should == "https://#{@account}.zendesk.com/"
  end
end

describe Zendesk::Main, 'make_request' do
  before do
    curl_object = Curl::Easy.method(:new)
    Curl::Easy.stub!(:new).and_return do |*args|
      curl = curl_object.call(*args)
      curl.should_receive(:perform)
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
    response.url.should =~ /foo=bar/
    response.url.should =~ /foo_list\[\]=1/
    response.url.should =~ /foo_list\[\]=2/
    response.url.should =~ /foo_list\[\]=3/

  end
end
