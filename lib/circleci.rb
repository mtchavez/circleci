require 'json'
require 'rest-client'
require 'net/http'
require 'hashie'

files = [
  'build',
  'config',
  'http',
  'project',
  'request_error',
  'response',
  'user'
]

files.each { |path| require_relative "./circleci/#{path}" }


module CircleCi

  extend self

  #
  # @example Configure CircleCi with your token
  #   CircleCi.configure do |config|
  #     config.token = 'my-token'
  #   end

  def configure
    yield config
  end

  #
  # @return [CircleCi::Config]

  def config
    @config ||= Config.new
  end

  def http # @private
    Http.new(config)
  end

end
