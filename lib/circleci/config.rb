module CircleCi
  ##
  #
  # Config class used internally.
  # Configure API calls using AlPapi.configure
  class Config
    DEFAULT_VERSION = 'v1'.freeze
    DEFAULT_HOST = 'https://circleci.com'.freeze
    DEFAULT_URI = "#{DEFAULT_HOST}/api/#{DEFAULT_VERSION}".freeze
    DEFAULT_PORT = 80

    attr_accessor :token, :host, :port, :request_overrides, :version

    ##
    #
    # @private

    def initialize
      @host = DEFAULT_HOST
      @port = DEFAULT_PORT
      @version = DEFAULT_VERSION
      @request_overrides = {}
    end

    def uri
      base = @host
      base += ":#{@port}" unless port_80? || host_has_port?
      base + "/api/#{@version}"
    end

    private

    def port_80?
      @port == DEFAULT_PORT
    end

    def host_has_port?
      @host =~ /:\d{1,7}$/
    end
  end
end
