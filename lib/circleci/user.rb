module CircleCi

  ##
  #
  # Class to access user details for a specific API key

  class User

    ##
    #
    # Get user account details
    #
    # @return [CircleCi::Response] - Response object

    def self.me
      CircleCi.http.get '/me'
    end

  end

end
