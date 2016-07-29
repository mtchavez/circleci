# frozen_string_literal: true
module CircleCi
  ##
  #
  # Response class is used to get access to raw HTTP request info
  class Response
    extend Forwardable

    def_delegators :@resp, :code, :message, :uri

    attr_reader :body

    ##
    # Initializing response object to be returned from API calls, used internally.
    #
    # @private
    def initialize(resp) # @private
      @resp = resp
      @body = parsed_body
    end

    ##
    #
    # Convenience method to determine if request was successfull or not
    # @return [Boolean]
    def success?
      case @resp.code.to_i
      when (200..299) then true
      else
        false
      end
    end

    private

    ##
    # Attempts to parse the response as JSON. Will rescue and return original
    # if unable to parse.
    #
    # @return [Hash,Array,String] A parsed JSON object or the original response body
    def parsed_body
      JSON.parse @resp.body
    rescue JSON::ParserError
      @resp.body
    end
  end
end
