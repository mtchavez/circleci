# frozen_string_literal: true
module CircleCi
  ##
  #
  # Class for getting all your Projects on CircleCI
  class Projects < ApiResource
    ##
    #
    # Initialize a Projects resource to get all projects
    #
    # @param config   [CircleCi::Config] - Defaults to [default_config] if not provided
    # @return         [CircleCi::Projects] - A Projects object
    def initialize(conf = nil)
      super(nil, nil, conf)
    end

    ##
    #
    # Get all projects for your API key
    #
    # @return [CircleCi::Response] - Response object
    def get
      CircleCi.request(conf, '/projects').get
    end
  end
end
