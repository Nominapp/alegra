module Alegra
  class Payments
    attr_reader :client

    def initialize(client)
      @client = client
    end

    # @param id [ Interger ]
    # @return [ Hash ]
    def find(id)
      client.get("payments/#{id}")
    end

    # Returs all payments
    # @return [ Array ]
    def list(params = {})
      client.get('payments', params)
    end

    # Creates a payment
    # @param params [ Hash ]
    #   - date [ String ]
    #   - bank_account [ Integer ] or [ Hash ]
    #   - payment_method [ String ]
    #   - observations [ String  ]
    #   - anotation [ String ]
    #   - type [ String ]
    #   - client [ Integer ] or [ Hash ]
    #   - invoices [ Array ]
    #   - bills [ Array ]
    #   - categories [ Array ]
    #   - retentions [ Array ]
    #   - currency [ Array ]
    # @return [ Hash ]
    def create(params)
      params = params.deep_camel_case_lower_keys
      client.post('payments', params)
    end

    # Creates a invoice
    # @param params [ Hash ]
    #   - date [ String ]
    #   - due_date [ String ]
    #   - price_list [ Array ]
    #   - currency [ Array ]
    #   - payments [ Array ]
    #   - client [ Integer ] or [ Hash ]
    #   - items [ Array ]
    #   - observations [ Array ]
    #   - anotations [ Array ]
    #   - terms_conditions [ Array ]
    #   - status [ String ]
    #   - number_template [ String ]
    #   - retenctions [ Array ]
    #   - seller [ String ]
    # @return [ Hash ]
    def update(id, params)
      _params = params.deep_camel_case_lower_keys
      client.put("invoices/#{ id }", _params)
    end

    # @param id [ Integer ]
    # @param params [ Hash ]
    #  - emails [ Array ]
    #  - send_copy_to_user [ Boolean ]
    #  - invoiceType [ String ]
    # @return [ Hash ]
    def send_by_email(id, params)
      _params = params.deep_camel_case_lower_keys
      client.post("invoices/#{ id }/email", _params)
    end
  end
end

