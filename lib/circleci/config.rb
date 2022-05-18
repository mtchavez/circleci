# frozen_string_literal: true

module CircleCi
  ##
  #
  # Config class used internally.
  # Configure API calls using CircleCi.configure
  class Config
    DEFAULT_VERSION = 'v1.1'.freeze
    DEFAULT_HOST = 'https://circleci.com'.freeze
    DEFAULT_URI = "#{DEFAULT_HOST}/api/#{DEFAULT_VERSION}".freeze
    DEFAULT_PORT = 443

    attr_accessor :token, :host, :port, :request_overrides, :version, :proxy,
                  :proxy_host, :proxy_port, :proxy_user, :proxy_pass, :logger

    ##
    #
    # @private
    # rubocop:disable Metrics/ParameterLists
    def initialize(host: DEFAULT_HOST, port: DEFAULT_PORT, proxy: nil, version: DEFAULT_VERSION, token: nil, request_overrides: {}, logger: nil)
      @host = host
      @port = port
      @proxy = proxy.nil? ? false : proxy
      @version = version
      @token = token
      @request_overrides = request_overrides
      @logger = logger || Logger.new($stdout)
    end
    # rubocop:enable Metrics/ParameterLists

    def uri
      URI.parse("#{@host || DEFAULT_HOST}:#{@port || DEFAULT_PORT}/api/#{@version || DEFAULT_VERSION}")
    end

    def proxy_userinfo?
      proxy_user && proxy_pass
    end

    def proxy_to_port
      proxy_port || 80
    end

    def proxy_uri
      return unless @proxy && proxy_host

      host_uri = URI.parse(proxy_host)
      userinfo = proxy_userinfo? ? "#{proxy_user}:#{proxy_pass}@" : ''
      URI.parse("#{host_uri.scheme}://#{userinfo}#{host_uri.host}:#{proxy_to_port}#{host_uri.path}")
    end
  end
end
