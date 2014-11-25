module CircleCi

    ##
    #
    # Class for managing builds for a project

  class Build

    ##
    #
    # Get a specific build for a project
    #
    # @param username [String] - User or org name who owns project
    # @param project  [String] - Name of project
    # @param build    [String] - Build ID
    # @return         [CircleCi::Response] - Response object

    def self.get username, project, build
      CircleCi.http.get "/project/#{username}/#{project}/#{build}"
    end

    ##
    #
    # Kick off a retry of a specific build
    #
    # @param username [String] - User or org name who owns project
    # @param project  [String] - Name of project
    # @param build    [String] - Build ID
    # @return         [CircleCi::Response] - Response object

    def self.retry username, project, build
      CircleCi.http.post "/project/#{username}/#{project}/#{build}/retry"
    end

    ##
    #
    # Get artifacts for a specific build of a project
    #
    # @param username [String] - User or org name who owns project
    # @param project  [String] - Name of project
    # @param build    [String] - Build ID
    # @return         [CircleCi::Response] - Response object

    def self.artifacts username, project, build
      CircleCi.http.get "/project/#{username}/#{project}/#{build}/artifacts"
    end

    ##
    #
    # Get tests for a specific build of a project
    #
    # @param username [String] - User or org name who owns project
    # @param project  [String] - Name of project
    # @param build    [String] - Build ID
    # @return         [CircleCi::Response] - Response object

    def self.tests username, project, build
      CircleCi.http.get "/project/#{username}/#{project}/#{build}/tests"
    end

  end

end
