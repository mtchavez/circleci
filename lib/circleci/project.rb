module CircleCi

  ##
  #
  # Class for interacting with Projects

  class Project

    ##
    #
    # Return all projects for your API key
    #
    # @return [CircleCi::Response] - Response object

    def self.all
      CircleCi.http.get '/projects'
    end

    ##
    #
    # Get all recent builds for a specific project
    #
    # @param username [String] - User or org name who owns project
    # @param project  [String] - Name of project
    # @return         [CircleCi::Response] - Response object

    def self.recent_builds username, project
      CircleCi.http.get "/project/#{username}/#{project}"
    end

    ##
    #
    # Get all recent builds for a specific branch of a project
    #
    # @param username [String] - User or org name who owns project
    # @param project  [String] - Name of project
    # @param branch   [String] - Name of branch
    # @return         [CircleCi::Response] - Response object

    def self.recent_builds_branch username, project, branch
      CircleCi.http.get "/project/#{username}/#{project}/tree/#{branch}"
    end

    ##
    #
    # Clear the build cache for a specific project
    #
    # @param username [String] - User or org name who owns project
    # @param project  [String] - Name of project
    # @return         [CircleCi::Response] - Response object

    def self.clear_cache username, project
      CircleCi.http.delete "/project/#{username}/#{project}/build-cache"
    end

  end

end

