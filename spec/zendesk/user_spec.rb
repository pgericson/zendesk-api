require "spec"
require 'lib/zendesk-api'

describe Zendesk::Main, 'user api' do
  # before do
  # end

  it "should be able to create" do
    data={"email" => "bob@aol.com", "name" => "Bob Jones", "roles" => 0, "restriction-id" => 4}
    curl_object = Curl::Easy.method(:new)
    Curl::Easy.stub!(:new).and_return do |*args|
      curl = curl_object.call(*args)
#      curl.stub!(:http_post)
      body=Zendesk::Main.to_xml('user', data)
      curl.should_receive(:http_post).with(body)
      curl.stub!(:perform)
      curl.stub!(:header_str) { "\r\nLocation: http://account.zendesk.com/users/23.xml\r\ndsaf: smoke"}
      curl.stub!(:response_code).and_return(201)
      curl
    end
    zendesk = Zendesk::Main.new('my_company', "some_login", "some_password")
    response = zendesk.create_user(data)
    response.url.should =~ %r{/users.xml}
    response.headers["Location"].should =~ %r{/users/23.xml}
    response.status.should == 201
  end
  
  it "should be able to update" do
    data={"email" => "bob@aol.com", "name" => "Bob Jones", "roles" => 0, "restriction-id" => 4}
    curl_object = Curl::Easy.method(:new)
    Curl::Easy.stub!(:new).and_return do |*args|
      curl = curl_object.call(*args)
      curl.stub!(:perform)
      body=Zendesk::Main.to_xml('user', data)
      curl.should_receive(:http_post).with(body)
      curl.stub!(:header_str) { "\r\ntest: blah"}
      curl.stub!(:response_code).and_return(200)      
      curl
    end    
    zendesk = Zendesk::Main.new('my_company', "some_login", "some_password")
    response = zendesk.update_user(39,data)
    response.curl.headers["X-Http-Method-Override"].should == "put"
    response.url.should =~ %r{/users/39.xml$}
    response.status.should == 200
  end
  
  it "should be able to get" do 
    curl_object = Curl::Easy.method(:new)
    Curl::Easy.stub!(:new).and_return do |*args|
      curl = curl_object.call(*args)
      curl.stub!(:perform)
      curl.stub!(:header_str) { "\r\ntest: blah"}
      curl.stub!(:response_code).and_return(200)      
      curl
    end    
    zendesk = Zendesk::Main.new('my_company', "some_login", "some_password")
    response = zendesk.get_user(13)
    response.url.should =~ %r{/users/13.xml$}
    response.status.should == 200
  end
  
  it "should be able to list all" do
    curl_object = Curl::Easy.method(:new)
    Curl::Easy.stub!(:new).and_return do |*args|
      curl = curl_object.call(*args)
      curl.stub!(:perform)
      curl.stub!(:header_str) { "\r\ntest: blah"}
      curl.stub!(:response_code).and_return(200)      
      curl
    end    
    zendesk = Zendesk::Main.new('my_company', "some_login", "some_password")
    response = zendesk.get_users
    response.url.should =~ %r{/users.xml$}
    response.status.should == 200
  end

  it "should be able to delete" do
    curl_object = Curl::Easy.method(:new)
    Curl::Easy.stub!(:new).and_return do |*args|
      curl = curl_object.call(*args)
      curl.stub!(:http_delete)
      curl.stub!(:perform)
      curl.stub!(:response_code).and_return(200)      
      curl.stub!(:header_str) { "\r\nadsf\r\ndsaf"}
      curl
    end    
    zendesk = Zendesk::Main.new('my_company', "some_login", "some_password")
    response = zendesk.delete_user(12)
    response.url.should =~ %r{/users/12.xml}
    response.status.should == 200
  end
end