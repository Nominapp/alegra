module Alegra
  class Estimates < Alegra::Record

    def find(id)
      client.get("estimates/#{id}")
    end

    def create(params)
      client.post('estimates', params)
    end

    def send_by_email(id, params)
      client.post("estimates/#{id}/email", params)
    end
  end
end
