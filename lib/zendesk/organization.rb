module Zendesk
  module Organization

    def get_organizations
      make_request("organizations")
    end

    def get_organization(id)
      make_request("organizations/#{id}")
    end

    def create_organization(input)
      make_request("organizations", :create => Zendesk::Main.to_xml('organization', input))
    end

    def update_organization(input)
      make_request("organizations", :update => Zendesk::Main.to_xml('organization', input))
    end

    def delete_organization(id)
      make_request("organizations/#{id}", :destroy => true)
    end
  end
end
