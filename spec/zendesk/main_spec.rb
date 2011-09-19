require "spec"
require 'zendesk-api'

describe Zendesk::Main do
  describe "basic" do
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

  describe 'make_request' do
    context "searching" do
      before do
        curl_object = Curl::Easy.method(:new)
        Curl::Easy.stub!(:new).and_return do |* args|
          curl = curl_object.call(* args)
          curl.should_receive(:perform)
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

    context "headers" do
      before(:each) do
        @zendesk = Zendesk::Main.new('my_company', "some_login", "some_password")
        @mock_object = mock('curl_connection')
        @mock_object.stub!(:userpwd=).and_return(true)
        @mock_object.stub!(:headers=).and_return({})
        @mock_object.stub!(:headers).and_return({})
        @mock_object.stub!(:body_str).and_return("body")
        @mock_object.stub!(:header_str).and_return("header")
        @mock_object.stub!(:url).and_return("url")
        @mock_object.stub!(:response_code).and_return("response_code")
        @mock_object.should_receive(:http_post).and_return(true)
        @curl_object = Curl::Easy.should_receive(:new).and_return(@mock_object)
      end
      it "should use default options if none are passed" do
        params = {"subject" => "rspec rulez", "description" => "description", "status_id"=>1}
        options_hash = {:on_behalf_of => "test@test.com"}

        options_hash.should_receive(:reverse_merge!).once.with({:on_behalf_of => nil})
        @mock_object.headers.should_receive(:merge!).once.with({"Content-Type" => "application/xml"}).and_return(true)
        @mock_object.headers.should_receive(:merge!).once.with({"X-On-Behalf-Of" => "test@test.com"}).and_return(true)

        @zendesk.make_request("ticket", {:create => params}, options_hash)
      end

      it "should format headers for creation" do
        params = {"subject" => "rspec rulez", "description" => "description", "status_id"=>1}

        @mock_object.headers.should_receive(:merge!).with({"Content-Type" => "application/xml"}).any_number_of_times.and_return(true)

        @zendesk.make_request("ticket", :create => params)
      end
      it "should add X-On-Behalf-Of if passed in options" do
        params = {"subject" => "rspec rulez", "description" => "description", "status_id"=>1}

        @mock_object.headers.should_receive(:merge!).once.with({"Content-Type" => "application/xml"}).and_return(true)
        @mock_object.headers.should_receive(:merge!).once.with({"X-On-Behalf-Of" => "test@test.com"}).and_return(true)

        @zendesk.make_request("ticket", {:create => params}, {:on_behalf_of => "test@test.com"})
      end
      it "should not add X-On-Behalf-Of if not passed in options" do
        params = {"subject" => "rspec rulez", "description" => "description", "status_id"=>1}

        @mock_object.headers.should_receive(:merge!).once.with({"Content-Type" => "application/xml"}).and_return(true)
        @mock_object.headers.should_not_receive(:merge!).with({"X-On-Behalf-Of" => ""}).and_return(true)

        @zendesk.make_request("ticket", {:create => params}, {:on_behalf_of => ""})
      end
    end
  end

  describe "#self.to_xml" do
    context "comments" do
      it "should output correctly formatted XML" do
        input = {"value" => "new comment", "public" => true}
        xml = Zendesk::Main.to_xml('comment', input)
        xml.should =~ /<comment>\s*<public type=\"boolean\">true<\/public>\s*<value>new comment<\/value>\s*<\/comment>/
      end
    end

    context "tickets" do
      it "should output correctly formatted XML" do
        input = {"subject" => "rspec rulez", "description" => "description", "status_id"=>1}
        xml = Zendesk::Main.to_xml('ticket', input)
        xml.should =~ /<ticket>\s*<subject>rspec rulez<\/subject>\s*<status-id type=\"integer\">1<\/status-id>\s*<description>description<\/description>\s*<\/ticket>/
      end
    end
  end
end