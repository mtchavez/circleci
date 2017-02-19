# frozen_string_literal: true
module CircleCi
  ##
  #
  # Class for interacting with and managing builds
  class Build < ApiResource
    attr_reader :build
    ##
    #
    # Initialize a Build object to interact with the Build API
    #
    # @param config   [CircleCi::Config] - Defaults to [default_config] if not provided
    # @param username [String] - User or org name who owns project
    # @param project  [String] - Name of project
    # @param build    [String] - Build ID
    # @return         [CircleCi::Build] - A Build object
    def initialize(username, project, build, conf = nil)
      super(username, project, conf)
      @build = build
    end

    ##
    #
    # Deprecated class methods
    class << self
      ##
      #
      # Get artifacts for a specific build of a project
      #
      # @deprecated Please use instance method of [CircleCi::Build] instead
      # @param username [String] - User or org name who owns project
      # @param project  [String] - Name of project
      # @param build    [String] - Build ID
      # @return         [CircleCi::Response] - Response object
      def artifacts(username, project, build)
        default_config.logger.warn('[Deprecated] Use instance method CircleCi::Build#artifacts instead')
        new(username, project, build, default_config).artifacts
      end

      ##
      #
      # Cancel a specific build
      #
      # @deprecated Please use instance method of [CircleCi::Build] instead
      # @param username [String] - User or org name who owns project
      # @param project  [String] - Name of project
      # @param build    [String] - Build ID
      # @return         [CircleCi::Response] - Response object
      def cancel(username, project, build)
        default_config.logger.warn('[Deprecated] Use instance method CircleCi::Build#cancel instead')
        new(username, project, build, default_config).cancel
      end

      ##
      #
      # Get a specific build for a project
      #
      # @deprecated Please use instance method of [CircleCi::Build] instead
      # @param username [String] - User or org name who owns project
      # @param project  [String] - Name of project
      # @param build    [String] - Build ID
      # @return         [CircleCi::Response] - Response object
      def get(username, project, build)
        default_config.logger.warn('[Deprecated] Use instance method CircleCi::Build#get instead')
        new(username, project, build, default_config).get
      end

      ##
      #
      # Kick off a retry of a specific build
      #
      # @deprecated Please use instance method of [CircleCi::Build] instead
      # @param username [String] - User or org name who owns project
      # @param project  [String] - Name of project
      # @param build    [String] - Build ID
      # @return         [CircleCi::Response] - Response object
      def retry(username, project, build)
        default_config.logger.warn('[Deprecated] Use instance method CircleCi::Build#retry instead')
        new(username, project, build, default_config).retry
      end

      ##
      #
      # Get tests for a specific build of a project
      #
      # @deprecated Please use instance method of [CircleCi::Build] instead
      # @param username [String] - User or org name who owns project
      # @param project  [String] - Name of project
      # @param build    [String] - Build ID
      # @return         [CircleCi::Response] - Response object
      def tests(username, project, build)
        default_config.logger.warn('[Deprecated] Use instance method CircleCi::Build#tests instead')
        new(username, project, build, default_config).tests
      end
    end

    ##
    #
    # Get artifacts for a specific build of a project
    #
    # @return [CircleCi::Response] - Response object
    def artifacts
      CircleCi.request(@conf, "/project/#{username}/#{project}/#{build}/artifacts").get
    end

    ##
    #
    # Cancel a specific build
    #
    # @return [CircleCi::Response] - Response object
    def cancel
      CircleCi.request(@conf, "/project/#{username}/#{project}/#{build}/cancel").post
    end

    ##
    #
    # Get a specific build for a project
    #
    # @return [CircleCi::Response] - Response object
    def get
      CircleCi.request(@conf, "/project/#{username}/#{project}/#{build}").get
    end

    ##
    #
    # Kick off a retry of a specific build
    #
    # @return [CircleCi::Response] - Response object
    def retry
      CircleCi.request(@conf, "/project/#{username}/#{project}/#{build}/retry").post
    end

    ##
    #
    # Get tests for a specific build of a project
    #
    # @return [CircleCi::Response] - Response object
    def tests
      CircleCi.request(@conf, "/project/#{username}/#{project}/#{build}/tests").get
    end
  end
end
