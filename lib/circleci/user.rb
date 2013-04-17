module CircleCi

  class User

    def self.me
      CircleCi.http.get '/me'
    end

  end

end
