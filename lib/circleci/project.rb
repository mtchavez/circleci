# frozen_string_literal: true
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
      CircleCi.request('/projects').get
    end

    ##
    #
    # Build the latest master push for this project
    #
    # @param username [String] - User or org name who owns project
    # @param project  [String] - Name of project
    # @return         [CircleCi::Response] - Response object
    def self.build(username, project)
      CircleCi.request("/#{project_path}/#{username}/#{project}").post
    end

    ##
    #
    # Build the latest push for this branch of a specific project
    #
    # @param username [String] - User or org name who owns project
    # @param project  [String] - Name of project
    # @param branch   [String] - Name of branch
    # @param body     [Hash] - Optional post body with build parameters
    # @return         [CircleCi::Response] - Response object
    def self.build_branch(username, project, branch, params = {}, body = {})
      CircleCi.request("/#{project_path}/#{username}/#{project}/tree/#{branch}", params).post(body)
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
    def self.build_ssh_key(username, project, build, key, hostname)
      body = { hostname: hostname, private_key: key }
      CircleCi.request("/#{project_path}/#{username}/#{project}/#{build}/ssh-users").post(body)
    end

    ##
    #
    # Clear the build cache for a specific project
    #
    # @param username [String] - User or org name who owns project
    # @param project  [String] - Name of project
    # @return         [CircleCi::Response] - Response object
    def self.clear_cache(username, project)
      CircleCi.request("/#{project_path}/#{username}/#{project}/build-cache").delete
    end

    ##
    #
    # Delete a checkout key for a project
    #
    # @param username     [String] - User or org name who owns project
    # @param project      [String] - Name of project
    # @param fingerprint  [String] - Fingerprint of a checkout key
    # @return             [CircleCi::Response] - Response object
    def self.delete_checkout_key(username, project, fingerprint)
      CircleCi.request("/#{project_path}/#{username}/#{project}/checkout-key/#{fingerprint}").delete
    end

    ##
    #
    # Enable a project in CircleCI. Causes a CircleCI SSH key to be added to
    # the GitHub. Requires admin privilege to the repository.
    #
    # @param username [String] - User or org name who owns project
    # @param project  [String] - Name of project
    # @return         [CircleCi::Response] - Response object
    def self.enable(username, project)
      CircleCi.request("/#{project_path}/#{username}/#{project}/enable").post
    end

    ##
    #
    # Get the project envvars
    #
    # @param username [String] - User or org name who owns project
    # @param project  [String] - Name of project
    # @return         [CircleCi::Response] - Response object
    def self.envvar(username, project)
      CircleCi.request("/#{project_path}/#{username}/#{project}/envvar").get
    end

    ##
    #
    # @deprecated Please use [CircleCi::Project#envvar]
    def self.envvars(username, project)
      # NOTE: Make logger configurable on config object?
      logger = Logger.new(STDOUT)
      logger.warn('[Deprecated] Project#envvars is deprecated please use Project#envvar')
      envvar username, project
    end

    ##
    #
    # Sets an envvar for a project
    #
    # @param username [String] - User or org name who owns project
    # @param project  [String] - Name of project
    # @param envvar   [Hash] - {name: 'foo', value: 'bar'}
    # @return         [CircleCi::Response] - Response object
    def self.set_envvar(username, project, envvar)
      CircleCi.request("/#{project_path}/#{username}/#{project}/envvar").post(envvar)
    end

    ##
    #
    # Follow the project
    #
    # @param username [String] - User or org name who owns project
    # @param project  [String] - Name of project
    # @return         [CircleCi::Response] - Response object
    def self.follow(username, project)
      CircleCi.request("/#{project_path}/#{username}/#{project}/follow").post
    end

    ##
    #
    # Get a checkout key for a project
    #
    # @param username     [String] - User or org name who owns project
    # @param project      [String] - Name of project
    # @param fingerprint  [String] - Fingerprint of a checkout key
    # @return             [CircleCi::Response] - Response object
    def self.get_checkout_key(username, project, fingerprint)
      CircleCi.request("/#{project_path}/#{username}/#{project}/checkout-key/#{fingerprint}").get
    end

    ##
    #
    # Get a list of checkout keys for project
    #
    # @param username [String] - User or org name who owns project
    # @param project  [String] - Name of project
    # @return         [CircleCi::Response] - Response object
    def self.list_checkout_keys(username, project)
      CircleCi.request("/#{project_path}/#{username}/#{project}/checkout-key").get
    end

    ##
    #
    # Create a checkout key for a project
    #
    # @param username [String] - User or org name who owns project
    # @param project  [String] - Name of project
    # @param type     [String] - The type of key to create. Can be 'deploy-key' or 'github-user-key'.
    # @return         [CircleCi::Response] - Response object

    def self.new_checkout_key(username, project, type)
      CircleCi.request("/#{project_path}/#{username}/#{project}/checkout-key").post(type: type)
    end

    ##
    #
    # Get all recent builds for a specific project
    #
    # @param username [String] - User or org name who owns project
    # @param project  [String] - Name of project
    # @param params   [Hash] - Parameters for builds (limit, offset, filter)
    # @return         [CircleCi::Response] - Response object

    def self.recent_builds(username, project, params = {})
      CircleCi.request("/#{project_path}/#{username}/#{project}", params).get
    end

    ##
    #
    # Get all recent builds for a specific branch of a project
    #
    # @param username [String] - User or org name who owns project
    # @param project  [String] - Name of project
    # @param branch   [String] - Name of branch
    # @return         [CircleCi::Response] - Response object
    def self.recent_builds_branch(username, project, branch)
      CircleCi.request("/#{project_path}/#{username}/#{project}/tree/#{branch}").get
    end

    ##
    #
    # Get the project configuration
    #
    # @param username [String] - User or org name who owns project
    # @param project  [String] - Name of project
    # @return         [CircleCi::Response] - Response object
    def self.settings(username, project)
      CircleCi.request("/#{project_path}/#{username}/#{project}/settings").get
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
    def self.ssh_key(username, project, key, hostname)
      body = { hostname: hostname, private_key: key }
      CircleCi.request("/#{project_path}/#{username}/#{project}/ssh-key").post(body)
    end

    ##
    #
    # Unfollow the project
    #
    # @param username [String] - User or org name who owns project
    # @param project  [String] - Name of project
    # @return         [CircleCi::Response] - Response object
    def self.unfollow(username, project)
      CircleCi.request("/#{project_path}/#{username}/#{project}/unfollow").post
    end
  private 
    def self.project_path
      # could also leverage the /:vcs-type/:username/:project path pattern for this section
      "project/#{CircleCi.config.vcs_type}"
    end
  end
end
