module CircleCi

  class Build

    def self.get username, project, build
      CircleCi.http.get "/project/#{username}/#{project}/#{build}"
    end

    def self.retry username, project, build
      CircleCi.http.post "/project/#{username}/#{project}/#{build}/retry"
    end

  end

end
