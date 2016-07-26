# frozen_string_literal: true
module CircleCi
  ##
  #
  # Class for interacting with recent builds
  class RecentBuilds
    ##
    #
    # Get get recent builds for your account
    #
    # @param params [Hash] - Params to send for recent builds (limit, offset)
    # @return         [CircleCi::Response] - Response object

    def self.get(params = {})
      CircleCi.http.get '/recent-builds', params
    end
  end
end
