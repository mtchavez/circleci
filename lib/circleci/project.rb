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
    # Build the latest push for this branch of a specific project
    #
    # @param username [String] - User or org name who owns project
    # @param project  [String] - Name of project
    # @param branch   [String] - Name of branch
    # @param build_parameters   [Hash] - Optional Build Parameters
    # @return         [CircleCi::Response] - Response object

    def self.build_branch username, project, branch, build_parameters = {}
      body = {}
      body["build_parameters"] = build_parameters unless build_parameters.empty?
      CircleCi.http.post "/project/#{username}/#{project}/tree/#{branch}", {}, body
    end

    ##
    #
    # Add a ssh key to a build
    #
    # @param username [String] - User or org name who owns project
    # @param project  [String] - Name of project
    # @param build    [String] - Build number
    # @param key      [String] - The ssh private key
    # @param hostname [String] - The hostname identified by the key
    # @return         [CircleCi::Response] - Response object
    def self.build_ssh_key username, project, build, key, hostname
      body = { hostname: hostname, private_key: key }
      CircleCi.http.post "/project/#{username}/#{project}/#{build}/ssh-users", {}, body
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
    # Enable a project in CircleCI. Causes a CircleCI SSH key to be added to
    # the GitHub. Requires admin privilege to the repository.
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
    # Get a checkout key for a project
    #
    # @param username     [String] - User or org name who owns project
    # @param project      [String] - Name of project
    # @param fingerprint  [String] - Fingerprint of a checkout key
    # @return         [CircleCi::Response] - Response object

    def self.get_checkout_key username, project, fingerprint
      CircleCi.http.get "/project/#{username}/#{project}/checkout-key/#{fingerprint}"
    end

    ##
    #
    # Get a list of checkout keys for project
    #
    # @param username [String] - User or org name who owns project
    # @param project  [String] - Name of project
    # @return         [CircleCi::Response] - Response object

    def self.list_checkout_keys username, project
      CircleCi.http.get "/project/#{username}/#{project}/checkout-key"
    end

    ##
    #
    # Create a checkout key for a project
    #
    # @param username [String] - User or org name who owns project
    # @param project  [String] - Name of project
    # @param type     [String] - The type of key to create. Can be 'deploy-key' or 'github-user-key'.
    # @return         [CircleCi::Response] - Response object

    def self.new_checkout_key username, project, type
      body = { type: type }
      CircleCi.http.post "/project/#{username}/#{project}/checkout-key", {}, body
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
    # Get the project configuration
    #
    # @param username [String] - User or org name who owns project
    # @param project  [String] - Name of project
    # @return         [CircleCi::Response] - Response object

    def self.settings username, project
      CircleCi.http.get "/project/#{username}/#{project}/settings"
    end

    ##
    #
    # Add a ssh key to a project
    #
    # @param username [String] - User or org name who owns project
    # @param project  [String] - Name of project
    # @param key      [String] - The ssh private key
    # @param hostname [String] - The hostname identified by the key
    # @return         [CircleCi::Response] - Response object
    def self.ssh_key username, project, key, hostname
      body = { hostname: hostname, private_key: key }
      CircleCi.http.post "/project/#{username}/#{project}/ssh-key", {}, body
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

  end

end

