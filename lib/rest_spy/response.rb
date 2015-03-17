require_relative 'encoding'

module RestSpy
  class Response
    def initialize(type, status_code, headers, body)
      @type = type
      @status_code = status_code
      @headers = headers
      @body = body
      @decoded_body = headers ? Encoding.decode(body, headers['Content-Encoding']) : body
    end

    def self.proxy(status_code, headers, body)
      Response.new('proxy', status_code, headers, body)
    end

    def self.double(double)
      Response.new('double', double.status_code, double.headers, double.body)
    end

    def self.not_found
      Response.new('not_found', 404, {}, '')
    end

    attr_reader :type, :status_code, :headers, :body, :decoded_body

    def to_hash
      puts "BODY: #{decoded_body}"
      {
          'type' => type,
          'status_code' => status_code,
          'body' => decoded_body
      }
    end
  end
end