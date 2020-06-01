require 'alegra/response'
module Alegra
  class Request
    attr_accessor :path, :token, :session

    def initialize(host, path, token = nil)
      @token = token
      @path = path
      @session = Faraday.new url: host
    end

    def get(url, attrs = {}, options = { format: :formated })
      retries = 1

      begin
        params = URI.encode_www_form(attrs)
        response = @session.get do |req|
          req.url "#{@path}#{url}?#{params}"
          req.headers['Content-Type'] = 'application/json'
          req.headers['Accept'] = 'application/json'
          req.headers['Authorization'] = "Basic #{@token}"
        end

        raise Timeout::Error.new if response.status == 429

        response_of_request(response, options)
      rescue Timeout::Error
        if retries == 1
          retries -= 1
          sleep(60)
          retry
        end
      end
    end

    def post(url, attrs = {}, options = { format: :formated })
      retries = 1

      begin
        params = JSON.generate(attrs)
        response = @session.post do |req|
          req.url "#{ @path }#{ url }"
          req.headers['Content-Type'] = 'application/json'
          req.headers['Accept'] = 'application/json'
          req.headers['Authorization'] = "Basic #{@token}"
          req.body = params
        end

        raise Timeout::Error.new if response.status == 429

        response_of_request(response, options)
      rescue Timeout::Error
        if retries == 1
          retries -= 1
          sleep(60)
          retry
        end
      end
    end

    def put(url, attrs = {}, options = { format: :formated })
      retries = 1

      begin
        params = JSON.generate(attrs)
        response = @session.put do |req|
          req.url "#{ @path }#{ url }"
          req.headers['Content-Type'] = 'application/json'
          req.headers['Accept'] = 'application/json'
          req.headers['Authorization'] = "Basic #{@token}"
          req.body = params
        end

        raise Timeout::Error.new if response.status == 429

        response_of_request(response, options)

      rescue Timeout::Error
        if retries == 1
          retries -= 1
          sleep(60)
          retry
        end
      end
    end

    def delete(url, attrs = {}, options = { format: :formated })
      retries = 1

      begin
        params = JSON.generate(attrs)

        response = @session.delete do |req|
          req.url "#{@path}#{url}"
          req.headers['Content-Type'] = 'application/json'
          req.headers['Accept'] = 'application/json'
          req.headers['Authorization'] = "Basic #{@token}"
          req.body = params
        end

        raise Timeout::Error.new if response.status == 429

        response_of_request(response, options)

      rescue Timeout::Error
        if retries == 1
          retries -= 1
          sleep(60)
          retry
        end
      end
    end

    private

    def response_of_request(response, options = { format: :formated })
      cast_error(response, options) unless response.status == 200 || response.status == 201

      raise_invalid_format options[:format]

      return response if options[:format] == :raw

      Alegra::Response.new(response.body).call
    end

    def cast_error(response, options = { format: :formated })
      raise_invalid_format options[:format]

      return response if options[:format] == :raw

      message = request_parsed_response(response)

      error_map = {
        500 => 'Server error! Something were wrong in the server.',
        400 => "Bad request!, #{message}",
        401 => 'Authentication error!',
        402 => 'Required payment!',
        403 => 'Restricted access!',
        404 => 'Not found!',
        405 => 'Operation does not allowed!'
      }
      raise StandardError, "Status: #{response.status}. Error: #{error_map[response.status]}"
    end

    def raise_invalid_format(format)
      return if %i[formated raw].include?(format)
      return if format.nil?

      raise StandardError, "#{format} is not a valid format, valid_formats[:formated, :raw]"
    end

    def request_parsed_response(response)
      if response.body.empty?
        response.body
      else
        parsed_message = Alegra::Response.new(response.body).call
        return parsed_message if parsed_message.is_a?(String)

        parsed_message.try(:[], :message)
      end
    end
  end
end
