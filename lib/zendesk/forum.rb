module Zendesk
  module Forum

    def get_forums
      make_request("forums")
    end

    def get_forum(id)
      make_request("forums/#{id}")
    end

    def create_forum(input)
      make_request("forums", :create => Zendesk::Main.to_xml('forum', input))
    end

    def update_forum(input)
      make_request("forums", :update => Zendesk::Main.to_xml('forum', input))
    end

    def delete_forum(id)
      make_request("forums/#{id}", :destroy => true)
    end
  end
end
