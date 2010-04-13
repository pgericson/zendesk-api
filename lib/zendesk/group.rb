module Zendesk
  module Group

    def get_groups
      make_request("groups")
    end

    def get_group(id)
      make_request("groups/#{id}")
    end

    def create_group(input)
      make_request("groups", :create => Zendesk::Main.to_xml('group', input))
    end

    def update_group(input)
      make_request("groups", :update => Zendesk::Main.to_xml('group', input))
    end

    def delete_group(id)
      make_request("groups/#{id}", :destroy => true)
    end
  end
end
