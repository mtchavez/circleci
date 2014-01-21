module CircleCi

  class Project

    def self.all
      CircleCi.http.get '/projects'
    end

    def self.recent_builds username, project
      CircleCi.http.get "/project/#{username}/#{project}"
    end

    def self.recent_builds_branch username, project, branch
      CircleCi.http.get "/project/#{username}/#{project}/tree/#{branch}"
    end

    def self.clear_cache username, project
      CircleCi.http.delete "/project/#{username}/#{project}/build-cache"
    end

  end

end

