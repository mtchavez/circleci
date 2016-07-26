# frozen_string_literal: true
module CircleCi
  ##
  #
  # RequestError takes http request info to raise more meaningful errors
  class RequestError
    attr_reader :message, :code, :path

    def initialize(err_message, err_code, err_path) # @private
      @message = err_message
      @code = err_code
      @path = err_path
    end
  end
end
