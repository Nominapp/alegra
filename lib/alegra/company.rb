module Alegra
  class Company
    attr_reader :client

    def initialize(client)
      @client = client
    end

    # Returns company
    # @param params [ Hash ]
    #   - start [ Integer ]
    #   - limit [ Integer ]
    #   - order_direction [ String ]
    #   - order_field [ string ]
    #   - query [ String ]
    #   - type [ Integer ]
    #   - metadata [ Boolean ]
    #   - name [ String ]
    #   - identification [ String ]
    # @return [ Array ]
    def find(params = {})
      client.get('company', params)
    end

    # @param id [ Integer ]
    # @param params [ Hash ]
    #   - name [ String ]
    #   - identification [ String ]
    #   - email [ String ]
    #   - phone_primary [ String ]
    #   - phone_secondary [ String ]
    #   - fax [ String ]
    #   - mobile [ String ]
    #   - observations [ String ]
    #   - ignore_repeated [ Boolean ]
    #   - price_list [ Hash ]
    #   - seller [ Hash ]
    #   - term [ Hash ]
    #   - type [ Array ]
    #   - address [ Hash ]
    #   - internal_contacts [ Array ]
    # @return [ Hash ]
    def update(id, params)
      sanitize_params = params.deep_camel_case_lower_keys
      client.put("contacts/#{id}", sanitize_params)
    end
  end
end
