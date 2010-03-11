module Zendesk
  module Tag

    def get_tags(params = nil)
      if params
        make_request("tags", :list => params)
      else
        make_request("tags")
      end
    end

  end
end
