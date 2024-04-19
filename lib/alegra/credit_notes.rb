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
      client.get('credit-notes', params)
    end

    # Create credit-note
    def create(params)
      sanitize_params = params.deep_camel_case_lower_keys
      client.post('credit-notes', sanitize_params)
    end
  end
end
