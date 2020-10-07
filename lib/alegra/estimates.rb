module Alegra
  class Estimates < Alegra::Record
    def create(params)
      client.post('estimates', params)
    end
  end
end
