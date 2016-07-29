# frozen_string_literal: true
module CircleCi
  ##
  #
  # Class for interacting with and managing builds
  class Build
    ##
    #
    # Get artifacts for a specific build of a project
    #
    # @param username [String] - User or org name who owns project
    # @param project  [String] - Name of project
    # @param build    [String] - Build ID
    # @return         [CircleCi::Response] - Response object
    def self.artifacts(username, project, build)
      CircleCi.request("/project/#{username}/#{project}/#{build}/artifacts").get
    end

    ##
    #
    # Cancel a specific build
    #
    # @param username [String] - User or org name who owns project
    # @param project  [String] - Name of project
    # @param build    [String] - Build ID
    # @return         [CircleCi::Response] - Response object
    def self.cancel(username, project, build)
      CircleCi.request("/project/#{username}/#{project}/#{build}/cancel").post
    end

    ##
    #
    # Get a specific build for a project
    #
    # @param username [String] - User or org name who owns project
    # @param project  [String] - Name of project
    # @param build    [String] - Build ID
    # @return         [CircleCi::Response] - Response object
    def self.get(username, project, build)
      CircleCi.request("/project/#{username}/#{project}/#{build}").get
    end

    ##
    #
    # Kick off a retry of a specific build
    #
    # @param username [String] - User or org name who owns project
    # @param project  [String] - Name of project
    # @param build    [String] - Build ID
    # @return         [CircleCi::Response] - Response object
    def self.retry(username, project, build)
      CircleCi.request("/project/#{username}/#{project}/#{build}/retry").post
    end

    ##
    #
    # Get tests for a specific build of a project
    #
    # @param username [String] - User or org name who owns project
    # @param project [String] - Name of project
    # @param build [String] - Build ID
    # @return [CircleCi::Response] - Response object

    def self.tests(username, project, build)
      CircleCi.request("/project/#{username}/#{project}/#{build}/tests").get
    end
  end
end
