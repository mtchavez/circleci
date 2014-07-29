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
    # Build the latest master push for this project
    #
    # @param username [String] - User or org name who owns project
    # @param project  [String] - Name of project
    # @return         [CircleCi::Response] - Response object

    def self.build username, project
      CircleCi.http.post "/project/#{username}/#{project}"
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
    # Build the latest push for this branch of a specific project
    #
    # @param username [String] - User or org name who owns project
    # @param project  [String] - Name of project
    # @param branch   [String] - Name of branch
    # @return         [CircleCi::Response] - Response object

    def self.build_branch username, project, branch
      CircleCi.http.post "/project/#{username}/#{project}/tree/#{branch}"
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

    ##
    #
    # Enable a project in CircleCI. Causes a CircleCI SSH key to be added to the GitHub. Requires admin privilege to the repository.
    #
    # @param username [String] - User or org name who owns project
    # @param project  [String] - Name of project
    # @return         [CircleCi::Response] - Response object

    def self.enable username, project
      CircleCi.http.post "/project/#{username}/#{project}/enable"
    end

    ##
    #
    # Follow the project
    #
    # @param username [String] - User or org name who owns project
    # @param project  [String] - Name of project
    # @return         [CircleCi::Response] - Response object

    def self.follow username, project
      CircleCi.http.post "/project/#{username}/#{project}/follow"
    end

    ##
    #
    # Unfollow the project
    #
    # @param username [String] - User or org name who owns project
    # @param project  [String] - Name of project
    # @return         [CircleCi::Response] - Response object

    def self.unfollow username, project
      CircleCi.http.post "/project/#{username}/#{project}/unfollow"
    end

    ##
    #
    # Get the project configuration
    #
    # @param username [String] - User or org name who owns project
    # @param project  [String] - Name of project
    # @return         [CircleCi::Response] - Response object

    def self.settings username, project
      CircleCi.http.get "/project/#{username}/#{project}/settings"
    end

  end

end

