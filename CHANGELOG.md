# Version 0.1.2 - Unreleased

* CircleCi::User#heroku_key – Add your Heroku API key to your account
* CircleCi::Project#ssh_key – Add an SSH key to a project
* CircleCi::Project#build_ssh_key – Add an SSH key to a project build

# Version 0.1.1 - (3-29-2015)

* Cancel a build merged in [#15](https://github.com/mtchavez/circleci/pull/15) from [@etiennebarrie](https://github.com/etiennebarrie)
* Tests endpoint for a build. Will return all tests ran with metadata.
  * Currently experimental tests endpoint needs to be turned on in Experimental Settings

# Version 0.1.0 - (11-4-2014)

* Loosen `rest-client` dependency to `~> 1.6`

# Version 0.0.9 - (11-4-2014)

* Deprecate `CircleCi::Response#parsed_body` to not use `hashie` gem

# Version 0.0.8 - (11-4-2014)

* Support [parameterized builds](https://circleci.com/docs/parameterized-builds)
  * Thanks to [@dlitvakb](https://github.com/dlitvakb) merged in [#15](https://github.com/mtchavez/circleci/pull/15)

# Version 0.0.7 - (8-1-2014)

* Add method to build specific branch of project - Thanks to [@hwartig](https://github.com/hwartig)

  * CircleCi::Project#build_branch - Triggers build for specific branch of project

# Version 0.0.6 - (6-8-2014)

* New hidden endpoints added to API - Thanks to [@EiNSTeiN-](https://github.com/EiNSTeiN-)

  * CircleCi::Project#build - Build the latest master push for this project
  * CircleCi::Project#enable - Enable a project in CircleCI
  * CircleCi::Project#follow - Follow a project in CircleCI
  * CircleCi::Project#unfollow - Unfollow a project in CircleCI
  * CircleCi::Project#settings - Get project configuration

# Version 0.0.3 - (1-29-2014)

* [Build artifacts](https://github.com/mtchavez/circleci/pull/3) added

# Version 0.0.2 - (1-21-2014)

* [Branch builds endpoint](https://github.com/mtchavez/circleci/pull/1)
* Ruby 2.0.0 in Gemfile
* More documentation

# Version 0.0.1 - (4-16-2013)

* Add basic endpoints
