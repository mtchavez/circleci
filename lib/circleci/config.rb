module CircleCi
  ##
  #
  # Config class used internally.
  # Configure API calls using AlPapi.configure

  class Config

    VERSION = 'v1'
    DEFAULT_HOST = "https://circleci.com/api/#{VERSION}"
    DEFAULT_PORT = 80

    attr_accessor :token, :host, :port

    ##
    #
    # @private

    def initialize
      @host = DEFAULT_HOST
      @port = DEFAULT_PORT
    end

  end

end
