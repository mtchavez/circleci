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

    class << self
      ##
      #
      # Get user account details
      #
      # @deprecated Please use instance method of [CircleCi::User] instead
      # @return [CircleCi::Response] - Response object
      def me
        default_config.logger.warn('[Deprecated] Use instance method CircleCi::User#me instead')
        new(default_config).me
      end

      ##
      #
      # Add a Heroku API key to CircleCI
      #
      # @deprecated Please use instance method of [CircleCi::User] instead
      # @param apikey   [String] - The Heroku API key
      # @return         [CircleCi::Response] - Response object
      def heroku_key(apikey)
        default_config.logger.warn('[Deprecated] Use instance method CircleCi::User#heroku_key instead')
        new(default_config).heroku_key(apikey)
      end
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
