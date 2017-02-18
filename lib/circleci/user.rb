# frozen_string_literal: true
module CircleCi
  ##
  #
  # User class to access user details for a specific API key
  class User < ApiResource
    ##
    #
    # Get user account details
    #
    # @deprecated Please use instance method of [CircleCi::User] instead
    # @return [CircleCi::Response] - Response object
    def self.me
      CircleCi.config.logger.warn('[Deprecated] Use instance method CircleCi::User#me instead')
      new(CircleCi.config).me
    end

    ##
    #
    # Add a Heroku API key to CircleCI
    #
    # @deprecated Please use instance method of [CircleCi::User] instead
    # @param apikey   [String] - The Heroku API key
    # @return         [CircleCi::Response] - Response object
    def self.heroku_key(apikey)
      CircleCi.config.logger.warn('[Deprecated] Use instance method CircleCi::User#heroku_key instead')
      new(CircleCi.config).heroku_key(apikey)
    end

    ##
    #
    # Get user account details
    #
    # @return [CircleCi::Response] - Response object
    def me
      CircleCi.request(@conf, '/me').get
    end

    ##
    #
    # Add a Heroku API key to CircleCI
    #
    # @param apikey   [String] - The Heroku API key
    # @return         [CircleCi::Response] - Response object
    def heroku_key(apikey)
      CircleCi.request(@conf, '/user/heroku-key').post(apikey: apikey)
    end
  end
end
