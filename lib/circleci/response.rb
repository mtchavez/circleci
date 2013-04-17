module CircleCi

  class Response

    attr_reader :success, :body, :errors, :code, :path, :params, :over_limit, :suspeneded

    ##
    # Initializing response object to be returned from API calls, used internally.
    #
    # @private

    def initialize(http, _code, _path, _params) # @private
      @success, @body, @errors = http.success, http.response, http.errors
      @over_limit, @suspended  = http.over_limit, http.suspended
      @code, @path, @params    = _code, _path, _params
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
    # Convenience method to see if you have reached your hourly limit
    # @return [Boolean]

    def over_limit?
      !!@over_limit
    end

    ##
    #
    # Convenience method to see if your account is supended
    # @return [Boolean]

    def suspended?
      !!@suspended
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
