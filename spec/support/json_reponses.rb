module JsonReponses

  include ItemsResponses
  include JournalsResponses

  #
  # Invoice reponses
  #

  def simple_invoice_response
    JSON.parse(File.read('./spec/fixtures/simple_invoice_response.json')).deep_underscore_keys
  end

  def create_invoice_response
    JSON.parse(File.read('./spec/fixtures/create_invoice_response.json')).deep_underscore_keys
  end

  def invoices_group_response
    JSON.parse(File.read('./spec/fixtures/invoices_group_response.json')).deep_underscore_keys
  end

  def update_invoice_response
    JSON.parse(File.read('./spec/fixtures/update_invoice_response.json')).deep_underscore_keys
  end

  def simple_estimate_response
    JSON.parse(File.read('./spec/fixtures/simple_estimate_response.json')).deep_underscore_keys
  end

  def create_estimate_response
    JSON.parse(File.read('./spec/fixtures/create_estimate_response.json')).deep_underscore_keys
  end
end
