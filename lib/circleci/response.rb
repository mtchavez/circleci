module CircleCi

  class Response

    attr_reader :success, :body, :errors, :code, :path
    ##
    # Initializing response object to be returned from API calls, used internally.
    #
    # @private

    def initialize(http, _code, _path) # @private
      @success, @body, @errors = http.success, http.response, http.errors
      @code, @path, @params    = _code, _path
    end

    ##
    #
    # Convenience method to determine if request was successfull or not
    # @return [Boolean]

    def success?
      !!@success
    end

    ##
    #
    # Parses JSON body of request and returns a Hashie::Mash
    # @return [Hashie::Mash]

    def parsed_body
      return @body if @body.is_a?(Array)
      Hashie::Mash.new(@body) rescue {}
    end

  end

end
