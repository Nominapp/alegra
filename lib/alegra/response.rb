require 'alegra/formatters/underscore_formatter'
module Alegra
  class Response
    attr_reader :body, :formatter

    def initialize(body, formatter_class_name='UnderscoreFormatter')
      @body = JSON.parse(body.force_encoding('UTF-8'))
    rescue JSON::ParserError => e
      @body = JSON.parse(body.force_encoding('UTF-8').to_json)
    ensure
      @formatter = Object.const_get("Alegra::Formatters::#{formatter_class_name}").new
    end

    def call(options={})
      if options[:none]
        JSON.parse(body)
      else
        formatter.call(content: body)
      end
    end
  end
end
