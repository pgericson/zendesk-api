module Zendesk
  module Search
    def search(params)
      make_request("search", :list => params)
    end
  end
end
