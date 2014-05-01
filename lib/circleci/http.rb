# encoding: utf-8

module CircleCi

  class Http # @private

    attr_accessor :errors, :response, :success, :config, :over_limit, :suspended

    def initialize(_config)
      @config, @errors, @success, @over_limit, @suspended = _config, [], false, false, false
    end

    def get(path, params = {})
      request 'get', "#{path}?#{RestClient::Payload.generate(build_params(params))}"
    end

    def post(path, params = {})
      request 'post', "#{path}?#{RestClient::Payload.generate(build_params(params))}"
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

    def request(http_verb, path)
      url  = "#{@config.host}#{path}"
      args = [http_verb, url, headers]

      response = RestClient.send *args do |res, req, raw_res|
        body = res.body
        code = raw_res.code.to_i

        self.response = body
        self.errors   = []

        if code == 200
          self.response = JSON.parse(body) rescue body
          self.success = true
        else
          self.errors << RequestError.new(body, code, path)
        end

        Response.new(self, code, path)
      end
    end

  end

end
