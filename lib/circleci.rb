# frozen_string_literal: true
require 'json'
require 'net/http'
require 'uri'

files = %w[
  build
  config
  project
  recent_builds
  request
  response
  user
]

files.each { |path| require_relative "./circleci/#{path}" }

##
#
# CircleCi module configured to for endpoint interactions
module CircleCi
  module_function

  ##
  #
  # @example Configure CircleCi with your token
  #   CircleCi.configure do |config|
  #     config.token = 'my-token'
  #   end
  def configure
    yield config
  end

  ##
  #
  # @return [CircleCi::Config]
  def config
    @config ||= Config.new
  end

  def request(path, params = {})
    Request.new config, path, params
  end
end
