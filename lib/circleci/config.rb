module CircleCi
  ##
  #
  # Config class used internally.
  # Configure API calls using AlPapi.configure
  class Config
    VERSION = 'v1'.freeze
    DEFAULT_HOST = "https://circleci.com/api/#{VERSION}".freeze
    DEFAULT_PORT = 80

    attr_accessor :token, :host
    attr_reader :port

    ##
    #
    # @private

    def initialize
      @host = DEFAULT_HOST
      @port = DEFAULT_PORT
    end
  end
end
