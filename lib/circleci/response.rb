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
    # *Deprecated* - To remove hashie dependency
    # Parses JSON body of request
    # @return [@body]

    def parsed_body
      @body
    end

  end

end
