# frozen_string_literal: true
module CircleCi
  ##
  #
  # Class for interacting with Projects
  # rubocop:disable Metrics/ClassLength
  class Project < ApiResource
    ##
    #
    # Deprecated class methods
    class << self
      ##
      #
      # Return all projects for your API key
      #
      # @deprecated Please use instance method of [CircleCi::Project] instead
      # @return [CircleCi::Response] - Response object
      def all
        default_config.logger.warn('[Deprecated] Use instance method CircleCi::Projects#get instead')
        CircleCi::Projects.new.get
      end

      ##
      #
      # Build the latest master push for this project
      #
      # @deprecated Please use instance method of [CircleCi::Project] instead
      # @param username [String] - User or org name who owns project
      # @param project  [String] - Name of project
      # @return         [CircleCi::Response] - Response object
      def build(username, project)
        default_config.logger.warn('[Deprecated] Use instance method CircleCi::Project#build instead')
        new(username, project, default_config).build
      end

      ##
      #
      # Build the latest push for this branch of a specific project
      #
      # @deprecated Please use instance method of [CircleCi::Project] instead
      # @param username [String] - User or org name who owns project
      # @param project  [String] - Name of project
      # @param branch   [String] - Name of branch
      # @param body     [Hash] - Optional post body with build parameters
      # @return         [CircleCi::Response] - Response object
      def build_branch(username, project, branch, params = {}, body = {})
        default_config.logger.warn('[Deprecated] Use instance method CircleCi::Project#build_branch instead')
        new(username, project, default_config).build_branch(branch, params, body)
      end

      ##
      #
      # Add a ssh key to a build
      #
      # @deprecated Please use instance method of [CircleCi::Project] instead
      # @param username [String] - User or org name who owns project
      # @param project  [String] - Name of project
      # @param build    [String] - Build number
      # @param key      [String] - The ssh private key
      # @param hostname [String] - The hostname identified by the key
      # @return         [CircleCi::Response] - Response object
      def build_ssh_key(username, project, build, key, hostname)
        default_config.logger.warn('[Deprecated] Use instance method CircleCi::Project#build_ssh_key instead')
        new(username, project, default_config).build_ssh_key(build, key, hostname)
      end

      ##
      #
      # Clear the build cache for a specific project
      #
      # @deprecated Please use instance method of [CircleCi::Project] instead
      # @param username [String] - User or org name who owns project
      # @param project  [String] - Name of project
      # @return         [CircleCi::Response] - Response object
      def clear_cache(username, project)
        default_config.logger.warn('[Deprecated] Use instance method CircleCi::Project#clear_cache instead')
        new(username, project, default_config).clear_cache
      end

      ##
      #
      # Delete a checkout key for a project
      #
      # @deprecated Please use instance method of [CircleCi::Project] instead
      # @param username     [String] - User or org name who owns project
      # @param project      [String] - Name of project
      # @param fingerprint  [String] - Fingerprint of a checkout key
      # @return             [CircleCi::Response] - Response object
      def delete_checkout_key(username, project, fingerprint)
        default_config.logger.warn('[Deprecated] Use instance method CircleCi::Project#delete_checkout_key instead')
        new(username, project, default_config).delete_checkout_key(fingerprint)
      end

      ##
      #
      # Enable a project in CircleCI. Causes a CircleCI SSH key to be added to
      # the GitHub. Requires admin privilege to the repository.
      #
      # @deprecated Please use instance method of [CircleCi::Project] instead
      # @param username [String] - User or org name who owns project
      # @param project  [String] - Name of project
      # @return         [CircleCi::Response] - Response object
      def enable(username, project)
        default_config.logger.warn('[Deprecated] Use instance method CircleCi::Project#enable instead')
        new(username, project, default_config).enable
      end

      ##
      #
      # Get the project envvars
      #
      # @deprecated Please use instance method of [CircleCi::Project] instead
      # @param username [String] - User or org name who owns project
      # @param project  [String] - Name of project
      # @return         [CircleCi::Response] - Response object
      def envvar(username, project)
        default_config.logger.warn('[Deprecated] Use instance method CircleCi::Project#envvar instead')
        new(username, project, default_config).envvar
      end

      ##
      #
      # @deprecated Please use [CircleCi::Project#envvar]
      def envvars(username, project)
        default_config.logger.warn('[Deprecated] CircleCi::Project#envvars is deprecated please use CircleCi::Project#envvar')
        envvar username, project
      end

      ##
      #
      # Follow the project
      #
      # @deprecated Please use instance method of [CircleCi::Project] instead
      # @param username [String] - User or org name who owns project
      # @param project  [String] - Name of project
      # @return         [CircleCi::Response] - Response object
      def follow(username, project)
        default_config.logger.warn('[Deprecated] Use instance method CircleCi::Project#follow instead')
        new(username, project, default_config).follow
      end

      ##
      #
      # Get a checkout key for a project
      #
      # @deprecated Please use instance method of [CircleCi::Project] instead
      # @param username     [String] - User or org name who owns project
      # @param project      [String] - Name of project
      # @param fingerprint  [String] - Fingerprint of a checkout key
      # @return             [CircleCi::Response] - Response object
      def get_checkout_key(username, project, fingerprint)
        default_config.logger.warn('[Deprecated] Use instance method CircleCi::Project#get_checkout_key instead')
        new(username, project, default_config).get_checkout_key(fingerprint)
      end

      ##
      #
      # Get a list of checkout keys for project
      #
      # @deprecated Please use instance method of [CircleCi::Project] instead
      # @param username [String] - User or org name who owns project
      # @param project  [String] - Name of project
      # @return         [CircleCi::Response] - Response object
      def list_checkout_keys(username, project)
        default_config.logger.warn('[Deprecated] Use instance method CircleCi::Project#list_checkout_keys instead')
        new(username, project, default_config).list_checkout_keys
      end

      ##
      #
      # Create a checkout key for a project
      #
      # @deprecated Please use instance method of [CircleCi::Project] instead
      # @param username [String] - User or org name who owns project
      # @param project  [String] - Name of project
      # @param type     [String] - The type of key to create. Can be 'deploy-key' or 'github-user-key'.
      # @return         [CircleCi::Response] - Response object
      def new_checkout_key(username, project, type)
        default_config.logger.warn('[Deprecated] Use instance method CircleCi::Project#new_checkout_key instead')
        new(username, project, default_config).new_checkout_key(type)
      end

      ##
      #
      # Get all recent builds for a specific project
      #
      # @deprecated Please use instance method of [CircleCi::Project] instead
      # @param username [String] - User or org name who owns project
      # @param project  [String] - Name of project
      # @param params   [Hash] - Parameters for builds (limit, offset, filter)
      # @return         [CircleCi::Response] - Response object
      def recent_builds(username, project, params = {})
        default_config.logger.warn('[Deprecated] Use instance method CircleCi::Project#recent_builds instead')
        new(username, project, default_config).recent_builds(params)
      end

      ##
      #
      # Get all recent builds for a specific branch of a project
      #
      # @deprecated Please use instance method of [CircleCi::Project] instead
      # @param username [String] - User or org name who owns project
      # @param project  [String] - Name of project
      # @param branch   [String] - Name of branch
      # @return         [CircleCi::Response] - Response object
      def recent_builds_branch(username, project, branch)
        default_config.logger.warn('[Deprecated] Use instance method CircleCi::Project#recent_builds_branch instead')
        new(username, project, default_config).recent_builds_branch(branch)
      end

      ##
      #
      # Get the project configuration
      #
      # @deprecated Please use instance method of [CircleCi::Project] instead
      # @param username [String] - User or org name who owns project
      # @param project  [String] - Name of project
      # @return         [CircleCi::Response] - Response object
      def settings(username, project)
        default_config.logger.warn('[Deprecated] Use instance method CircleCi::Project#settings instead')
        new(username, project, default_config).settings
      end

      ##
      #
      # Sets an envvar for a project
      #
      # @deprecated Please use instance method of [CircleCi::Project] instead
      # @param username [String] - User or org name who owns project
      # @param project  [String] - Name of project
      # @param envvar   [Hash] - {name: 'foo', value: 'bar'}
      # @return         [CircleCi::Response] - Response object
      def set_envvar(username, project, envvar)
        default_config.logger.warn('[Deprecated] Use instance method CircleCi::Project#add_envvar instead')
        new(username, project, default_config).add_envvar(envvar)
      end

      ##
      #
      # Add a ssh key to a project
      #
      # @deprecated Please use instance method of [CircleCi::Project] instead
      # @param username [String] - User or org name who owns project
      # @param project  [String] - Name of project
      # @param key      [String] - The ssh private key
      # @param hostname [String] - The hostname identified by the key
      # @return         [CircleCi::Response] - Response object
      def ssh_key(username, project, key, hostname)
        default_config.logger.warn('[Deprecated] Use instance method CircleCi::Project#ssh_key instead')
        new(username, project, default_config).ssh_key(key, hostname)
      end

      ##
      #
      # Unfollow the project
      #
      # @deprecated Please use instance method of [CircleCi::Project] instead
      # @param username [String] - User or org name who owns project
      # @param project  [String] - Name of project
      # @return         [CircleCi::Response] - Response object
      def unfollow(username, project)
        default_config.logger.warn('[Deprecated] Use instance method CircleCi::Project#unfollow instead')
        new(username, project, default_config).unfollow
      end
    end

    ##
    #
    # Build the latest master push for this project
    #
    # @return [CircleCi::Response] - Response object
    def build
      CircleCi.request(@conf, "/project/#{username}/#{project}").post
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
      CircleCi.request(@conf, "/project/#{username}/#{project}/tree/#{branch}", params).post(body)
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
      CircleCi.request(@conf, "/project/#{username}/#{project}/#{build}/ssh-users").post(body)
    end

    ##
    #
    # Clear the build cache for a specific project
    #
    # @return [CircleCi::Response] - Response object
    def clear_cache
      CircleCi.request(@conf, "/project/#{username}/#{project}/build-cache").delete
    end

    ##
    #
    # Delete a checkout key for a project
    #
    # @param fingerprint  [String] - Fingerprint of a checkout key
    # @return             [CircleCi::Response] - Response object
    def delete_checkout_key(fingerprint)
      CircleCi.request(@conf, "/project/#{username}/#{project}/checkout-key/#{fingerprint}").delete
    end

    ##
    #
    # Enable a project in CircleCI. Causes a CircleCI SSH key to be added to
    # the GitHub. Requires admin privilege to the repository.
    #
    # @return [CircleCi::Response] - Response object
    def enable
      CircleCi.request(@conf, "/project/#{username}/#{project}/enable").post
    end

    ##
    #
    # Get the project envvars
    #
    # @return [CircleCi::Response] - Response object
    def envvar
      CircleCi.request(@conf, "/project/#{username}/#{project}/envvar").get
    end

    ##
    #
    # Follow the project
    #
    # @return [CircleCi::Response] - Response object
    def follow
      CircleCi.request(@conf, "/project/#{username}/#{project}/follow").post
    end

    ##
    #
    # Get a checkout key for a project
    #
    # @param fingerprint  [String] - Fingerprint of a checkout key
    # @return             [CircleCi::Response] - Response object
    def get_checkout_key(fingerprint)
      CircleCi.request(@conf, "/project/#{username}/#{project}/checkout-key/#{fingerprint}").get
    end

    ##
    #
    # Get a list of checkout keys for project
    #
    # @return [CircleCi::Response] - Response object
    def list_checkout_keys
      CircleCi.request(@conf, "/project/#{username}/#{project}/checkout-key").get
    end

    ##
    #
    # Create a checkout key for a project
    #
    # @param type [String] - The type of key to create. Can be 'deploy-key' or 'github-user-key'.
    # @return     [CircleCi::Response] - Response object
    def new_checkout_key(type)
      CircleCi.request(@conf, "/project/#{username}/#{project}/checkout-key").post(type: type)
    end

    ##
    #
    # Get all recent builds for a specific project
    #
    # @param params   [Hash] - Parameters for builds (limit, offset, filter)
    # @return         [CircleCi::Response] - Response object
    def recent_builds(params = {})
      CircleCi.request(@conf, "/project/#{username}/#{project}", params).get
    end

    ##
    #
    # Get all recent builds for a specific branch of a project
    #
    # @param branch [String] - Name of branch
    # @return       [CircleCi::Response] - Response object
    def recent_builds_branch(branch)
      CircleCi.request(@conf, "/project/#{username}/#{project}/tree/#{branch}").get
    end

    ##
    #
    # Get the project configuration
    #
    # @return [CircleCi::Response] - Response object
    def settings
      CircleCi.request(@conf, "/project/#{username}/#{project}/settings").get
    end

    ##
    #
    # Adds an envvar for a project
    #
    # @param envvar [Hash] - {name: 'foo', value: 'bar'}
    # @return       [CircleCi::Response] - Response object
    def add_envvar(envvar)
      CircleCi.request(@conf, "/project/#{username}/#{project}/envvar").post(envvar)
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
      CircleCi.request(@conf, "/project/#{username}/#{project}/ssh-key").post(body)
    end

    ##
    #
    # Unfollow the project
    #
    # @return [CircleCi::Response] - Response object
    def unfollow
      CircleCi.request(@conf, "/project/#{username}/#{project}/unfollow").post
    end
  end
  # rubocop:enable Metrics/ClassLength
end
