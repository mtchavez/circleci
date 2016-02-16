module CircleCi
  ##
  #
  # Response class is used to get access to raw HTTP request info
  class Response
    attr_reader :success, :body, :errors, :code, :path
    ##
    # Initializing response object to be returned from API calls, used internally.
    #
    # @private

    def initialize(http, resp_code, resp_path) # @private
      @success = http.success
      @body = http.response
      @errors = http.errors
      @code = resp_code
      @path = resp_path
    end

    ##
    #
    # Convenience method to determine if request was successfull or not
    # @return [Boolean]

    def success?
      @success == true
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
