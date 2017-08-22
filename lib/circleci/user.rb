# frozen_string_literal: true

module CircleCi
  ##
  #
  # User class to access user details for a specific API key
  class User < ApiResource
    ##
    #
    # Initialize a new User API interaction
    #
    # @param conf [CircleCi::Config] - Optional config to use for request
    # @return     [CircleCi::User]
    def initialize(conf = nil)
      super(nil, nil, conf)
    end

    ##
    #
    # Get user account details
    #
    # @return [CircleCi::Response] - Response object
    def me
      CircleCi.request(conf, '/me').get
    end

    ##
    #
    # Add a Heroku API key to CircleCI
    #
    # @param apikey   [String] - The Heroku API key
    # @return         [CircleCi::Response] - Response object
    def heroku_key(apikey)
      CircleCi.request(conf, '/user/heroku-key').post(apikey: apikey)
    end
  end
end
