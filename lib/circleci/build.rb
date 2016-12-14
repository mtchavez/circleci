# frozen_string_literal: true
module CircleCi
  ##
  #
  # Class for interacting with and managing builds
  class Build
    attr_reader :project, :build_num

    ##
    # Initialize build
    #
    # @param project [CircleCI::Project] - The project which this build belongs to
    # @param build_num [int] - The build number
    def initialize(project, build_num)
      @project = project
      @build_num = build_num
    end

    ##
    # Get artifacts for a specific build of a project
    #
    # @return         [CircleCi::Response] - Response object
    def artifacts
      CircleCi.request("#{base_path}/artifacts").get
    end

    ##
    # Cancel a specific build
    #
    # @return         [CircleCi::Response] - Response object
    def cancel
      CircleCi.request("#{base_path}/cancel").post
    end

    ##
    # Get a specific build for a project
    #
    # @return         [CircleCi::Response] - Response object
    def get
      CircleCi.request("#{base_path}").get
    end

    ##
    # Kick off a retry of a specific build
    #
    # @return         [CircleCi::Response] - Response object
    def retry
      CircleCi.request("#{base_path}/retry").post
    end

    ##
    # Get tests for a specific build of a project
    #
    # @return [CircleCi::Response] - Response object
    def tests
      CircleCi.request("/project/#{username}/#{project}/#{build}/tests").get
    end

  private 
    def base_path
      @base_path ||= "/project/#{project.vcs_type}/#{project.username}/#{project.name}/#{build_num}"
    end
  end
end
