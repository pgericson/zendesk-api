module Zendesk
  module Ticket

    def get_tickets(rule_id)
      make_request("rules/#{rule_id}")
    end

    def get_ticket(id)
      make_request("tickets/#{id}")
    end

    def create_ticket(input, options = {})
      make_request("tickets", {:create => Zendesk::Main.to_xml('ticket', input)}, options)
    end

    def update_ticket(id, input, options = {})
      make_request("tickets/#{id}", {:update => Zendesk::Main.to_xml('ticket', input)}, options)
    end

    def delete_ticket(id)
      make_request("tickets/#{id}", :destroy => true)
    end
  end
end
