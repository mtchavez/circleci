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

    ##
    #
    # Add a Heroku API key to CircleCI
    #
    # @param apikey   [String] - The Heroku API key
    # @return         [CircleCi::Response] - Response object
    def self.heroku_key apikey
      body = { apikey: apikey }
      CircleCi.http.post '/user/heroku-key', {}, body
    end

  end

end
