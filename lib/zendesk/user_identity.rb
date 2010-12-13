module Zendesk
  module UserIdentity

    def user_add_twitter(user_id, twitter)
      make_request("users/#{user_id}/user_identities", :create => "<twitter>#{twitter}</twitter>")
    end
    
    def user_primary_identity(user_id, id)
      make_request("users/#{user_id}/user_identities/#{id}/make_primary", :post => true)
    end
        
    def user_add_email(user_id, email)
      make_request("users/#{user_id}/user_identities", :create => "<email>#{email}</email>")
    end
    
    def user_delete_identity(user_id, id)
      make_request("users/#{user_id}/user_identities/#{id}", :destroy => true)
    end
    
    def user_identities(user_id)
      make_request("users/#{user_id}/user_identities")
    end

  end
end
