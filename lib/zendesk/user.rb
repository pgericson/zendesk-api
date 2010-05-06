module Zendesk
  module User

    def get_users(params = nil)
      if params
        make_request("users", :list => params)
      else
        make_request("users")
      end
    end

    def get_user(id)
      make_request("users/#{id}")
    end

    def create_user(input)
      make_request("users", :create => Zendesk::Main.to_xml('user', input))
    end

    def update_user(id, input)
      make_request("users/#{id}", :update => Zendesk::Main.to_xml('user', input))
    end

    def delete_user(id)
      make_request("users/#{id}", :destroy => true)
    end
  end
end
