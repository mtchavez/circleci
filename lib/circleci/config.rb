module CircleCi
  ##
  #
  # Config class used internally.
  # Configure API calls using AlPapi.configure

  class Config

    VERSION = 'v1'
    DEFAULT_HOST = "https://circleci.com/api/#{VERSION}"
    DEFAULT_PORT = 80 # @private

    attr_accessor :token
    attr_reader   :host, :port # @private

    ##
    #
    # @private

    def initialize
      @host = DEFAULT_HOST
      @port = DEFAULT_PORT
    end

  end

end
