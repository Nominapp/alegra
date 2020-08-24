module Alegra
  class CostCenters < Alegra::Record
    def list(params = {})
      client.get('cost-centers', params)
    end

    def find(id)
      client.get("cost-centers/#{id}")
    end
  end
end
