module Alegra
  class CreditNotes < Alegra::Record
    # @param id [ Integer ]
    # @return [ Hash ]
    def find(id)
      client.get("credit-notes/#{id}")
    end

    # Returs all credit-notes
    # @param params [ Hash ]
    #   - start [ Integer ]
    #   - limit [ Integer ]
    #   - metadata [ Boolean ]
    #   - id [ Integer ]
    #   - item_id [ Integer ]
    #   - client_id [ Integer ]
    #   - attachment [ Boolean ]
    #   - number [ String  ]
    #   - client_name [ String ]
    #   - date [ String ]
    #   - emission_status [ String ]
    # @return [ Array ]
    def list(params = {})
      client.get('invoices', params)
    end
  end
end
