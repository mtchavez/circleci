# frozen_string_literal: true
require 'json'
require 'logger'
require 'net/http'
require 'uri'

files = %w[
  api_resource
  build
  config
  project
  projects
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

  def request(conf, path, params = {})
    Request.new conf, path, params
  end
end
