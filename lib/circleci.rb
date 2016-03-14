require 'json'
require 'httparty'
require 'net/http'

files = %w[
  build
  config
  http
  project
  recent_builds
  request_error
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

  def http # @private
    Http.new(config)
  end
end
