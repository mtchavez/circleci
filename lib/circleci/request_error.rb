module CircleCi

  class RequestError

    attr_reader :message, :code, :path

    def initialize(_message, _code, _path) # @private
      @message, @code, @path = _message, _code, _path
    end

  end

end
