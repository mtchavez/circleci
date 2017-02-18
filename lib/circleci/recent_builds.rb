# frozen_string_literal: true
module CircleCi
  ##
  #
  # Class for interacting with recent builds
  class RecentBuilds < ApiResource

    ##
    #
    # Initialize a new RecentBuilds API interaction
    #
    # @param conf [CircleCi::Config] - Optional config to use for request
    # @return     [CircleCi::RecentBuilds]
    def initialize(conf = nil)
      super(nil, nil, conf)
    end

    ##
    #
    # Deprecated class methods
    class << self
      ##
      #
      # Get get recent builds for your account
      #
      # @deprecated Please use instance method of [CircleCi::RecentBuilds] instead
      # @param params [Hash] - Params to send for recent builds (limit, offset)
      # @return         [CircleCi::Response] - Response object
      def get(params = {})
        CircleCi.config.logger.warn('[Deprecated] Use instance method CircleCi::RecentBuilds#get instead')
        new(CircleCi.config).get(params)
      end
    end

    ##
    #
    # Get get recent builds for your account
    #
    # @param params [Hash] - Params to send for recent builds (limit, offset)
    # @return       [CircleCi::Response] - Response object
    def get(params = {})
      CircleCi.request(@conf, '/recent-builds', params).get
    end
  end
end
