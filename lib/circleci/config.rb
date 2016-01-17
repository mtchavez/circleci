module CircleCi
  ##
  #
  # Config class used internally.
  # Configure API calls using AlPapi.configure

  class Config

    VERSION = 'v1'
    DEFAULT_HOST = "https://circleci.com/api/#{VERSION}"
    DEFAULT_PORT = 80
    DEFAULT_PROXY = nil

    attr_accessor :token, :host, :port, :proxy

    ##
    #
    # @private

    def initialize
      @host = DEFAULT_HOST
      @port = DEFAULT_PORT
      @proxy = DEFAULT_PROXY
    end

  end

end
