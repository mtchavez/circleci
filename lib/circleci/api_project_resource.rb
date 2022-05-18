# frozen_string_literal: true

module CircleCi
  ##
  #
  # Class for interacting with project API resources
  class ApiProjectResource < ApiResource
    VALID_VCS_TYPES = %w[github bitbucket].freeze
    DEFAULT_VCS_TYPE = VALID_VCS_TYPES.first.freeze

    attr_reader :build, :vcs_type

    ##
    #
    # Initialize a new Project API interaction
    #
    # @param username [String] - The vcs username or org name for project
    # @param project  [String] - The project name
    # @param vcs_type [String] - The vcs type i.e. github or bitbucket
    # @param build    [String] - The build number for a project
    # @param conf     [CircleCi::Config] - Optional config to use for request
    # @return         [CircleCi::Project]
    def initialize(username = nil, project = nil, vcs_type = nil, build = nil, conf = nil) # rubocop:disable Metrics/ParameterLists
      super(username, project, conf)
      @vcs_type = VALID_VCS_TYPES.include?(vcs_type) ? vcs_type : DEFAULT_VCS_TYPE
      @build = build
    end

    def base_path
      "/project/#{vcs_type}/#{username}/#{project}"
    end
  end
end
