module CircleCi

  class RequestError

    attr_reader :message, :code, :path, :params

    def initialize(_message, _code, _path, _params) # @private
      @message, @code, @path, @params = _message, _code, _path, _params
    end

  end

end
