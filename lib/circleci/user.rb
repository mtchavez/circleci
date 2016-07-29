# frozen_string_literal: true
module CircleCi
  ##
  #
  # User class to access user details for a specific API key
  class User
    ##
    #
    # Get user account details
    #
    # @return [CircleCi::Response] - Response object
    def self.me
      CircleCi.request('/me').get
    end

    ##
    #
    # Add a Heroku API key to CircleCI
    #
    # @param apikey   [String] - The Heroku API key
    # @return         [CircleCi::Response] - Response object
    def self.heroku_key(apikey)
      CircleCi.request('/user/heroku-key').post(apikey: apikey)
    end
  end
end
