# frozen_string_literal: true

module CircleCi
  ##
  #
  # Class for interacting with Projects
  class Project < ApiProjectResource
    ##
    #
    # Initialize a new Project API interaction
    #
    # @param username [String] - The vcs username or org name for project
    # @param project  [String] - The project name
    # @param vcs_type [String] - The vcs type i.e. github or bitbucket
    # @param conf     [CircleCi::Config] - Optional config to use for request
    # @return         [CircleCi::Project]
    def initialize(username = nil, project = nil, vcs_type = nil, conf = nil)
      super(username, project, vcs_type, nil, conf)
    end

    ##
    #
    # Build the latest master push for this project
    #
    # @return [CircleCi::Response] - Response object
    def build
      CircleCi.request(conf, base_path).post
    end

    ##
    #
    # Build the latest push for this branch of a specific project
    #
    # @param branch   [String] - Name of branch
    # @param params   [Hash] - Optional params to send for building
    # @param body     [Hash] - Optional post body with build parameters
    # @return         [CircleCi::Response] - Response object
    def build_branch(branch, params = {}, body = {})
      CircleCi.request(conf, "#{base_path}/tree/#{branch}", params).post(body)
    end

    ##
    #
    # Add a ssh key to a build
    #
    # @param build    [String] - Build number
    # @param key      [String] - The ssh private key
    # @param hostname [String] - The hostname identified by the key
    # @return         [CircleCi::Response] - Response object
    def build_ssh_key(build, key, hostname)
      body = { hostname: hostname, private_key: key }
      CircleCi.request(conf, "#{base_path}/#{build}/ssh-users").post(body)
    end

    ##
    #
    # Clear the build cache for a specific project
    #
    # @return [CircleCi::Response] - Response object
    def clear_cache
      CircleCi.request(conf, "#{base_path}/build-cache").delete
    end

    ##
    #
    # Delete a checkout key for a project
    #
    # @param fingerprint  [String] - Fingerprint of a checkout key
    # @return             [CircleCi::Response] - Response object
    def delete_checkout_key(fingerprint)
      CircleCi.request(conf, "#{base_path}/checkout-key/#{fingerprint}").delete
    end

    ##
    #
    # Enable a project in CircleCI. Causes a CircleCI SSH key to be added to
    # the GitHub. Requires admin privilege to the repository.
    #
    # @return [CircleCi::Response] - Response object
    def enable
      CircleCi.request(conf, "#{base_path}/enable").post
    end

    ##
    #
    # Get the project envvars
    #
    # @return [CircleCi::Response] - Response object
    def envvar
      CircleCi.request(conf, "#{base_path}/envvar").get
    end

    ##
    #
    # Follow the project
    #
    # @return [CircleCi::Response] - Response object
    def follow
      CircleCi.request(conf, "#{base_path}/follow").post
    end

    ##
    #
    # Get a checkout key for a project
    #
    # @param fingerprint  [String] - Fingerprint of a checkout key
    # @return             [CircleCi::Response] - Response object
    def get_checkout_key(fingerprint)
      CircleCi.request(conf, "#{base_path}/checkout-key/#{fingerprint}").get
    end

    ##
    #
    # Get a list of checkout keys for project
    #
    # @return [CircleCi::Response] - Response object
    def list_checkout_keys
      CircleCi.request(conf, "#{base_path}/checkout-key").get
    end

    ##
    #
    # Create a checkout key for a project
    #
    # @param type [String] - The type of key to create. Can be 'deploy-key' or 'github-user-key'.
    # @return     [CircleCi::Response] - Response object
    def new_checkout_key(type)
      CircleCi.request(conf, "#{base_path}/checkout-key").post(type: type)
    end

    ##
    #
    # Get all recent builds for a specific project
    #
    # @param params   [Hash] - Parameters for builds (limit, offset, filter)
    # @return         [CircleCi::Response] - Response object
    def recent_builds(params = {})
      CircleCi.request(conf, base_path, params).get
    end

    ##
    #
    # Get all recent builds for a specific branch of a project
    #
    # @param branch   [String] - Name of branch
    # @param params   [Hash] - Parameters for builds (limit, offset, filter)
    # @return         [CircleCi::Response] - Response object
    def recent_builds_branch(branch, params = {})
      CircleCi.request(conf, "#{base_path}/tree/#{branch}", params).get
    end

    ##
    #
    # Get the project configuration
    #
    # @return [CircleCi::Response] - Response object
    def settings
      CircleCi.request(conf, "#{base_path}/settings").get
    end

    ##
    #
    # Adds an envvar for a project
    #
    # @param envvar [Hash] - {name: 'foo', value: 'bar'}
    # @return       [CircleCi::Response] - Response object
    def add_envvar(envvar)
      CircleCi.request(conf, "#{base_path}/envvar").post(envvar)
    end

    ##
    #
    # Deletes an envvar for a project
    #
    # @param envvar [String] - 'TESTENV'
    # @return       [CircleCi::Response] - Response object
    def delete_envvar(envvar)
      CircleCi.request(conf, "#{base_path}/envvar/#{envvar}").delete
    end

    ##
    #
    # Add a ssh key to a project
    #
    # @param key      [String] - The ssh private key
    # @param hostname [String] - The hostname identified by the key
    # @return         [CircleCi::Response] - Response object
    def ssh_key(key, hostname)
      body = { hostname: hostname, private_key: key }
      CircleCi.request(conf, "#{base_path}/ssh-key").post(body)
    end

    ##
    #
    # Unfollow the project
    #
    # @return [CircleCi::Response] - Response object
    def unfollow
      CircleCi.request(conf, "#{base_path}/unfollow").post
    end
  end
end
