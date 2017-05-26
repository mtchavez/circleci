# frozen_string_literal: true
module CircleCi
  ##
  #
  # Class for interacting with and managing builds
  class Build < ApiProjectResource
    ##
    #
    # Get artifacts for a specific build of a project
    #
    # @return [CircleCi::Response] - Response object
    def artifacts
      CircleCi.request(conf, "#{base_path}/#{build}/artifacts").get
    end

    ##
    #
    # Cancel a specific build
    #
    # @return [CircleCi::Response] - Response object
    def cancel
      CircleCi.request(conf, "#{base_path}/#{build}/cancel").post
    end

    ##
    #
    # Get a specific build for a project
    #
    # @return [CircleCi::Response] - Response object
    def get
      CircleCi.request(conf, "#{base_path}/#{build}").get
    end

    ##
    #
    # Kick off a retry of a specific build
    #
    # @return [CircleCi::Response] - Response object
    def retry
      CircleCi.request(conf, "#{base_path}/#{build}/retry").post
    end

    ##
    #
    # Get tests for a specific build of a project
    #
    # @return [CircleCi::Response] - Response object
    def tests
      CircleCi.request(conf, "#{base_path}/#{build}/tests").get
    end
  end
end
