# encoding: utf-8

module CircleCi
  ##
  #
  # Http class handles all HTTP requests
  class Http # @private
    attr_accessor :errors, :response, :success, :config, :over_limit, :suspended

    def initialize(config)
      @config = config
      @errors = []
      @success = false
      @over_limit = false
      @suspended = false
    end

    def get(path, params = {})
      request 'get', "#{path}?#{payload_generate(build_params(params))}"
    end

    def payload_generate(params)
      URI.encode_www_form(params)
    end

    def post(path, params = {}, body = {})
      request 'post', "#{path}?#{payload_generate(build_params(params))}", body
    end

    def delete(path, params = {})
      request 'delete', "#{path}?#{payload_generate(build_params(params))}"
    end

    def headers
      { 'accept' => 'application/json', 'content-type' => 'application/json' }
    end

    def build_params(params = {})
      params.merge('circle-token' => @config.token)
    end

    def create_request_args(http_verb, body)
      args = {
        headers: headers }
      args[:payload] = body if http_verb.to_sym == :post
      args.merge!(@config.request_overrides)
      args
    end

    def request(http_verb, path, body = {})
      url  = "#{@config.uri}#{path}"
      args = create_request_args http_verb, body
      response = HTTParty.public_send(http_verb, url, args)
      handle_response(response, path)
      Response.new(self, response.code, path)
    end

    def handle_response(http_response, path)
      self.errors   = []

      parsed = http_response.parsed_response
      unless parsed.respond_to?(:to_h)
        begin
          parsed = JSON.parse(parsed)
        rescue JSON::ParserError
        end
      end

      successful_code = (200..299).cover?(http_response.code)
      self.response = parsed if parsed
      self.success = true

      # Some responses are empty but are successful
      if http_response.body == '""' && successful_code
        self.response = ''
      elsif parsed && successful_code
        # Response is successful
      else
        self.success = false
        self.errors = [RequestError.new(http_response.body, http_response.code, path)]
      end
    end
  end
end
