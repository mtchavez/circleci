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
      request 'get', "#{path}?#{RestClient::Payload.generate(build_params(params))}"
    end

    def post(path, params = {}, body = {})
      request 'post', "#{path}?#{RestClient::Payload.generate(build_params(params))}", body
    end

    def delete(path, params = {})
      request 'delete', "#{path}?#{RestClient::Payload.generate(build_params(params))}"
    end

    def headers
      { 'accept' => 'application/json', 'content-type' => 'application/json' }
    end

    def build_params(params = {})
      params.merge('circle-token' => @config.token)
    end

    def create_request_args(http_verb, url, body)
      args = {
        method: http_verb.to_sym,
        url: url,
        headers: headers }
      args[:payload] = body if http_verb == 'post'
      args.merge!(@config.request_overrides)
      args
    end

    def request(http_verb, path, body = {})
      url  = "#{@config.uri}#{path}"
      args = create_request_args http_verb, url, body

      RestClient::Request.execute(args) do |res, _, raw_res|
        body = res.body.to_s
        body.force_encoding(Encoding::UTF_8)
        code = raw_res.code.to_i

        self.response = body
        self.errors   = []

        handle_response(body, code, path)
        Response.new(self, code, path)
      end
    end

    def parsed_body(body)
      JSON.parse(body)
    rescue
      nil
    end

    def handle_response(body, code, path)
      parsed = parsed_body(body)
      successful_code = (200..299).cover?(code)
      self.response = parsed if parsed
      self.success = true

      # Some responses are empty but are successful
      if body == '""' && successful_code
        self.response = ''
      elsif parsed && successful_code
        # Response is successful
      else
        self.success = false
        self.errors = [RequestError.new(body, code, path)]
      end
    end
  end
end
