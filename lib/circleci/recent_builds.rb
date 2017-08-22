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
    # Get get recent builds for your account
    #
    # @param params [Hash] - Params to send for recent builds (limit, offset)
    # @return       [CircleCi::Response] - Response object
    def get(params = {})
      CircleCi.request(conf, '/recent-builds', params).get
    end
  end
end
