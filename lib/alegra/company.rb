module Alegra
  class Company < Alegra::Record
    def find(options = { format: :formated })
      client.get('company', {}, options)
    end

    def update(params)
      sanitize_params = params.deep_camel_case_lower_keys
      client.put('company', sanitize_params)
    end
  end
end
