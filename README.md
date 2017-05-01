# circleci

[![Latest Version](https://img.shields.io/gem/v/circleci.svg)](http://rubygems.org/gems/circleci)
[![Circle CI](https://circleci.com/gh/mtchavez/circleci.svg?style=svg)](https://circleci.com/gh/mtchavez/circleci)
[![Code Climate](https://codeclimate.com/github/mtchavez/circleci.png)](https://codeclimate.com/github/mtchavez/circleci)
[![Coverage Status](https://coveralls.io/repos/mtchavez/circleci/badge.png)](https://coveralls.io/r/mtchavez/circleci)
[![Dependency Status](https://gemnasium.com/mtchavez/circleci.svg)](https://gemnasium.com/mtchavez/circleci)

Circle CI API Wrapper. Requires ruby `>= 2.0.0`.

## Install

```ruby
gem install circleci
```

or with Bundler

```ruby
gem 'circleci'
```

## Usage

### Configuring

#### Global Config

Configure using an API token from Circle

```ruby
CircleCi.configure do |config|
  config.token = 'my-token'
end
```

Optionally you can configure your own host and/or port if using an enterprise
CircleCi host. The port will default to `80` if not set.

```ruby
CircleCi.configure do |config|
  config.token = 'my-token'
  config.host = 'https://ci.mycompany.com'
  config.port = 1234
end
```

Overriding request settings such as not verifying SSL

```ruby
CircleCi.configure do |config|
  config.token = ENV['CIRCLECI_TOKEN']
  config.host = 'http://ci.mycompany.com'
  config.port = 80
  config.request_overrides = {
    use_ssl: false,
    verify_ssl: false
  }
end
```

Setup for proxying requests
```ruby
require 'circleci'

CircleCi.configure do |config|
  config.token = ENV['CIRCLECI_TOKEN']
  config.proxy_host = 'http://ciproxy.mycompany.com'
  config.proxy_port = 8000
  config.proxy_user = 'myci'
  config.proxy_pass = 'supersecret'
  config.proxy = true
end
```

#### Config Object

If you need to use custom config per request or for specific non-global cases
you can instantiate a `CircleCi::Config` object with all the same granularity
as a global config.

```ruby
# Using a new token
config = CircleCi::Config.new token: ENV['SECRET_CIRCLECI_TOKEN']

# Setting a new host
config_options = { host: ENV['CIRCLECI_HOST'], port: ENV['CIRCLECI_PORT'] }
config = CircleCi::Config.new

# Proxy setup is a little more invovled right now
# and requires setting proxy info on instantiated config
config = CircleCi::Config.new token: ENV['CIRCLECI_TOKEN'], proxy: true
config.proxy_host = ENV['CIRCLECI_PROXY_HOST']
config.proxy_port = ENV['CIRCLECI_PROXY_PORT']
config.proxy_user = ENV['CIRCLECI_PROXY_USER']
config.proxy_pass = ENV['CIRCLECI_PROXY_PASS']
```

## API Endpoints

* [User](#user)
  * [Heroku Key](#heroku_key)
  * [Me](#me)
* [Project](#project)
  * [All](#all)
  * [Build Branch](#build_branch)
  * [Build SSH Key](#build_ssh_key)
  * [Clear Cache](#clear_cache)
  * [Enable](#enable)
  * [Envvar](#envvar)
  * [Follow](#follow)
  * [Delete Checkout Key](#delete_checkout_key)
  * [Get Checkout Key](#get_checkout_key)
  * [List Checkout Keys](#list_checkout_keys)
  * [New Checkout Key](#new_checkout_key)
  * [Recent Builds](#project_recent_builds)
  * [Recent Builds Branch](#recent_builds_branch)
  * [Settings](#settings)
  * [Set Envvar](#set_envvar)
  * [SSH Key](#ssh_key)
  * [Unfollow](#unfollow)
* [Build](#build)
  * [Artifacts](#artifacts)
  * [Cancel](#cancel)
  * [Get](#get)
  * [Retry](#retry)
  * [Tests](#tests)
* [Recent Builds](#recent_builds)
  * [Get](#recent_builds_get)

### [User](#user)

#### [heroku_key](#heroku_key)

Endpoint: `/user/heroku-key`

Adds your Heroku API key to CircleCI.
```ruby
res = CircleCi::User.heroku_key 'your-api-key'
res.success? # True
res.body
```

Using `CircleCi::User` instance and overriding config
```ruby
# Use global config with token for user
user = CircleCi::User.new
user.heroku_key 'your-api-key'

# Use a different config with another user token
user = CircleCi::User.new other_user_config
user.heroku_key 'your-api-key'
```

Example response

Empty body response with a `200 OK` response code
```javascript
""
```

#### [me](#me)

Endpoint: `/me`

Provides information about the signed in user.

```ruby
res = CircleCi::User.me
res.success? # True
res.body
```

Using `CircleCi::User` instance and overriding config
```ruby
# Use global config with token for user
user = CircleCi::User.new
user.me

# Use a different config with another user token
user = CircleCi::User.new other_user_config
user.me
```

Example response

```javascript
{
  "basic_email_prefs" : "smart", // can be "smart", "none" or "all"
  "login" : "pbiggar" // your github username
}
```

### [Project](#project)

#### [all](#all)

Endpoint: `/projects`

List of all the repos you have access to on Github, with build information organized by branch.

```ruby
res = CircleCi::Project.all
res.success?
res.body
```

Using `CircleCi::Projects` instance and overriding config

```ruby
# Use global config with token for user
projects = CircleCi::Projects.new
projects.get

# Use a different config with another projects token
projects = CircleCi::Projects.new other_projects_config
projects.get
```

Example response

```javascript
[ {
  "vcs_url": "https://github.com/circleci/mongofinil"
  "followed": true // true if you follow this project in Circle
  "branches" : {
    "master" : {
      "pusher_logins" : [ "pbiggar", "arohner" ], // users who have pushed
      "last_non_success" : { // last failed build on this branch
        "pushed_at" : "2013-02-12T21:33:14Z",
        "vcs_revision" : "1d231626ba1d2838e599c5c598d28e2306ad4e48",
        "build_num" : 22,
        "outcome" : "failed",
        },
      "last_success" : { // last successful build on this branch
        "pushed_at" : "2012-08-09T03:59:53Z",
        "vcs_revision" : "384211bbe72b2a22997116a78788117b3922d570",
        "build_num" : 15,
        "outcome" : "success",
        },
      "recent_builds" : [ { // last 5 builds, ordered by pushed_at (decreasing)
        "pushed_at" : "2013-02-12T21:33:14Z",
        "vcs_revision" : "1d231626ba1d2838e599c5c598d28e2306ad4e48",
        "build_num" : 22,
        "outcome" : "failed",
        }, {
        "pushed_at" : "2013-02-11T03:09:54Z",
        "vcs_revision" : "0553ba86b35a97e22ead78b0d568f6a7c79b838d",
        "build_num" : 21,
        "outcome" : "failed",
        }, ... ],
      "running_builds" : [ ] // currently running builds
    }
  }
} ]
```

#### [build_branch](#build_branch)

Endpoint: `/project/:username/:repository/tree/:branch`

Build a specific branch of a project

```ruby
res = CircleCi::Project.build_branch 'username', 'reponame', 'branch'
res.body['status'] # Not running
res.body['build_url'] # Get url of build

# Passing build parameters in the post body
build_params = { build_parameters: { 'MY_TOKEN' => '123asd123asd' } }
res = CircleCi::Project.build_branch 'username', 'reponame', 'branch', {}, build_params
res.body['status'] # Not running
res.body['build_url'] # Get url of build

# Adding URL params for revision or parallel
params = { revision: 'fda12345asdf', parallel: 2 }
res = CircleCi::Project.build_branch 'username', 'reponame', 'branch', params
res.body['status'] # Not running
res.body['build_url'] # Get url of build
```

Example response

```javascript
{
  "compare" : null,
  "previous_successful_build" : {
    "build_time_millis" : 40479,
    "status" : "success",
    "build_num" : 76
  },
  "build_parameters" : { },
  "committer_date" : "2014-07-27T14:40:15Z",
  "body" : "",
  "usage_queued_at" : "2014-07-29T14:05:36.373Z",
  "retry_of" : null,
  "reponame" : "soapy_cake",
  "build_url" : "https://circleci.com/gh/ad2games/soapy_cake/77",
  "parallel" : 1,
  "failed" : null,
  "branch" : "master",
  "username" : "ad2games",
  "author_date" : "2014-07-27T14:40:15Z",
  "why" : "edit",
  "user" : {
    "is_user" : true,
    "login" : "hwartig",
    "name" : "Harald Wartig",
    "email" : "hw@ad2games.com"
  },
  "vcs_revision" : "f932ea1b564ceaaa8cdba06b1bb93e1869a9a905",
  "build_num" : 77,
  "infrastructure_fail" : false,
  "ssh_enabled" : null,
  "committer_email" : "hwartig@gmail.com",
  "previous" : {
    "build_time_millis" : 40479,
    "status" : "success",
    "build_num" : 76
  },
  "status" : "not_running",
  "committer_name" : "Harald Wartig",
  "retries" : null,
  "subject" : "Fix link to api_versions.yml",
  "timedout" : false,
  "dont_build" : null,
  "feature_flags" : { },
  "lifecycle" : "not_running",
  "stop_time" : null,
  "build_time_millis" : null,
  "circle_yml" : null,
  "messages" : [ ],
  "is_first_green_build" : false,
  "job_name" : null,
  "start_time" : null,
  "all_commit_details" : [ {
    "committer_date" : "2014-07-27T14:40:15Z",
    "body" : "",
    "author_date" : "2014-07-27T14:40:15Z",
    "committer_email" : "hwartig@gmail.com",
    "commit" : "f932ea1b564ceaaa8cdba06b1bb93e1869a9a905",
    "committer_login" : "hwartig",
    "committer_name" : "Harald Wartig",
    "subject" : "Fix link to api_versions.yml",
    "commit_url" : "https://github.com/ad2games/soapy_cake/commit/f932ea1b564ceaaa8cdba06b1bb93e1869a9a905",
    "author_login" : "hwartig",
    "author_name" : "Harald Wartig",
    "author_email" : "hwartig@gmail.com"
  } ],
  "outcome" : null,
  "vcs_url" : "https://github.com/ad2games/soapy_cake",
  "author_name" : "Harald Wartig",
  "node" : null,
  "canceled" : false,
  "author_email" : "hwartig@gmail.com"
}
```

It also supports the Experimental Parameterized Builds

```
  build_environment_variables = {"ENV_VAR1" => "VALUE1", "ENV_VAR2" => "VALUE2"}
  res = CircleCi::Project.build_branch 'username', 'reponame', 'branch', build_environment_variables
```

#### [build_ssh_key](#build_ssh_key)

Endpoint: `/project/:username/:repository/:build_num/ssh-users`

Adds a user to the build's SSH permissions.

```ruby
res = CircleCi::Project.build_ssh_key 'username', 'repo', 'RSA private key', 'hostname'
res.success?
```

Example response

Empty response body with a `200 OK` successful response code
```javascript
""
```

#### [clear_cache](#clear_cache)

Endpoint: `/project/:username/:repository/build-cache`

Clears the cache for a project

```ruby
res = CircleCi::Project.clear_cache
res.body['status']
```

Example response

```javascript
{
  "status" : "build caches deleted"
}
```

#### [delete_checkout_key](#delete_checkout_key)

Endpoint: `/project/:username/:repository/checkout-key/:fingerprint`

Delete a checkout key for a project by supplying the fingerprint of the key.
```ruby
res = CircleCi::Project.delete_checkout_key 'username', 'reponame', 'fingerprint'
res.success?
res.body
```

Example response

```javascript
{"message":"ok"}
```

#### [enable](#enable)

Endpoint: `/project/:username/:repository/enable`

Enable a project in CircleCI. Causes a CircleCI SSH key to be added to
the GitHub. Requires admin privilege to the repository.

```ruby
res = CircleCi::Project.enable 'username', 'reponame'
res.success?
```

Example response
```javascript
{
    "hall_notify_prefs": nil,
    "irc_password": nil,
    "default_branch": "master",
    "hipchat_notify": nil,
    "campfire_notify_prefs": nil,
    "campfire_room": nil,
    "irc_keyword": nil,
    "slack_api_token": nil,
    "parallel": 1,
    "github_user": nil,
    "github_permissions": {
        "admin": true,
        "push": true,
        "pull": true
    },
    "irc_server": nil,
    "heroku_deploy_user": nil,
    "dependencies": "",
    "slack_notify_prefs": nil,
    "ssh_keys": [

    ],
    "extra": "",
    "followed": false,
    "branches": {
        "master": {
            "last_non_success": {
                "added_at": "2014-06-05T17:23:25.352Z",
                "pushed_at": "2014-06-05T17:22:52.518Z",
                "vcs_revision": "66d398cb635c5f4dd666dd1526bda5894d1246e4",
                "build_num": 6,
                "status": "no_tests",
                "outcome": "no_tests"
            },
            "recent_builds": [
                {
                    "added_at": "2014-06-05T17:23:25.352Z",
                    "pushed_at": "2014-06-05T17:22:52.518Z",
                    "vcs_revision": "66d398cb635c5f4dd666dd1526bda5894d1246e4",
                    "build_num": 6,
                    "status": "no_tests",
                    "outcome": "no_tests"
                }
            ],
            "running_builds": [

            ]
        }
    },
    "campfire_token": nil,
    "hipchat_notify_prefs": nil,
    "test": "",
    "compile": "",
    "hipchat_room": nil,
    "slack_channel": nil,
    "slack_subdomain": nil,
    "vcs_url": "https://github.com/Shopify/google_auth",
    "flowdock_api_token": nil,
    "hall_room_api_token": nil,
    "slack_webhook_url": nil,
    "irc_username": nil,
    "hipchat_api_token": nil,
    "campfire_subdomain": nil,
    "has_usable_key": true,
    "setup": "",
    "irc_channel": nil,
    "feature_flags": {
        "build_GH1157_container_oriented_ui": nil,
        "set-github-status": true
    },
    "irc_notify_prefs": nil
}
```

#### [envvar](#envvar)

Endpoint: `/project/:username/:project/envvar`

Get a list of environment variables for a project

```ruby
res = CircleCi::Project.envvar 'username', 'repo'
res.success?
```

Example response

```javascript
[{"name":"foo","value":"xxxx"}]
```

#### [follow](#follow)

Endpoint: `/project/:username/:repository/follow`

Follow a project

```ruby
res = CircleCi::Build.follow 'username', 'repo'
res.success?
```

Example response

```javascript
{
    "followed": true,
    "first_build": nil
}
```

#### [get_checkout_key](#get_checkout_key)

Endpoint: `/project/:username/:repository/checkout-key/:fingerprint`

Get a checkout key for a project by supplying the fingerprint of the key.
```ruby
res = CircleCi::Project.get_checkout_key 'username', 'reponame', 'fingerprint'
res.success?
res.body
```

Example response

```javascript
{
    "public_key": "ssh-rsa...",
    "type": "deploy-key", // can be "deploy-key" or "user-key"
    "fingerprint": "c9:0b:1c:4f:d5:65:56:b9:ad:88:f9:81:2b:37:74:2f",
    "preferred": true,
    "time" : "2015-09-21T17:29:21.042Z" // when the key was issued
}
```

#### [list_checkout_keys](#list_checkout_keys)

Endpoint: `/project/#{username}/#{project}/checkout-key`

List checkout keys

```ruby
res = CircleCi::Project.checkout_keys 'username', 'repo'
res.success?
```

Example response

```javascript
[
    {
        "public_key": "ssh-rsa...",
        "type": "deploy-key", // can be "deploy-key" or "user-key"
        "fingerprint": "c9:0b:1c:4f:d5:65:56:b9:ad:88:f9:81:2b:37:74:2f",
        "preferred": true,
        "time" : "2015-09-21T17:29:21.042Z" // when the key was issued
    }
]
```

#### [new_checkout_key](#new_checkout_key)

Endpoint: `/project/:username/:repository/checkout-key`

Create an ssh key used to access external systems that require SSH key-based authentication.
Takes a type of key to create which an be `deploy-key` or `github-user-key`.
```ruby
res = CircleCi::Project.new_checkout_key 'username', 'reponame', 'deploy-key'
res.success?
res.body
```

Example response

```javascript
{
    "public_key": "ssh-rsa...",
    "type": "deploy-key", // can be "deploy-key" or "user-key"
    "fingerprint": "c9:0b:1c:4f:d5:65:56:b9:ad:88:f9:81:2b:37:74:2f",
    "preferred": true,
    "time" : "2015-09-21T17:29:21.042Z" // when the key was issued
}
```

#### [recent_builds](#project_recent_builds)

Endpoint: `/project/:username/:repository`

Build summary for each of the last 30 recent builds, ordered by build_num.

```ruby
res = CircleCi::Project.recent_builds 'username', 'reponame'

# Use params to filter by status
# res = CircleCi::Project.recent_builds 'username', 'reponame', filter: 'failed'

# Use params to limit and give an offset
# res = CircleCi::Project.recent_builds 'username', 'reponame', limit: 10, offset: 50

res.success?
res.body
```

Example response

```javascript
[ {
  "vcs_url" : "https://github.com/circleci/mongofinil",
  "build_url" : "https://circleci.com/gh/circleci/mongofinil/22",
  "build_num" : 22,
  "branch" : "master",
  "vcs_revision" : "1d231626ba1d2838e599c5c598d28e2306ad4e48",
  "committer_name" : "Allen Rohner",
  "committer_email" : "arohner@gmail.com",
  "subject" : "Don't explode when the system clock shifts backwards",
  "body" : "", // commit message body
  "why" : "github", // short string explaining the reason we built
  "dont_build" : null, // reason why we didn't build, if we didn't build
  "queued_at" : "2013-02-12T21:33:30Z" // time build was queued
  "start_time" : "2013-02-12T21:33:38Z", // time build started running
  "stop_time" : "2013-02-12T21:34:01Z", // time build finished running
  "build_time_millis" : 23505,
  "lifecycle" : "finished",
  "outcome" : "failed",
  "status" : "failed",
  "retry_of" : null, // build_num of the build this is a retry of
  "previous" : { // previous build
    "status" : "failed",
    "build_num" : 21
  } ]
```

#### [recent_builds_branch](#recent_builds_branch)

Endpoint: `/project/:username/:repository/tree/:branch`

Build summary for each of the last 30 recent builds for a specific branch, ordered by build_num.

```ruby
res = CircleCi::Project.recent_builds_branch 'username', 'reponame', 'branch'
res.success?
res.body
```

Example response

```javascript
[ {
  "vcs_url" : "https://github.com/circleci/mongofinil",
  "build_url" : "https://circleci.com/gh/circleci/mongofinil/22",
  "build_num" : 22,
  "branch" : "new_feature",
  "vcs_revision" : "1d231626ba1d2838e599c5c598d28e2306ad4e48",
  "committer_name" : "Allen Rohner",
  "committer_email" : "arohner@gmail.com",
  "subject" : "Don't explode when the system clock shifts backwards",
  "body" : "", // commit message body
  "why" : "github", // short string explaining the reason we built
  "dont_build" : null, // reason why we didn't build, if we didn't build
  "queued_at" : "2013-02-12T21:33:30Z" // time build was queued
  "start_time" : "2013-02-12T21:33:38Z", // time build started running
  "stop_time" : "2013-02-12T21:34:01Z", // time build finished running
  "build_time_millis" : 23505,
  "lifecycle" : "finished",
  "outcome" : "failed",
  "status" : "failed",
  "retry_of" : null, // build_num of the build this is a retry of
  "previous" : { // previous build
    "status" : "failed",
    "build_num" : 21
  } ]
```

#### [settings](#settings)

Endpoint: `/project/:username/:repository/settings`

Get project settings

```ruby
res = CircleCi::Project.settings 'username', 'repo'
res.success?
```

Example response

```javascript
{
    "hall_notify_prefs": nil,
    "irc_password": nil,
    "default_branch": "master",
    "hipchat_notify": nil,
    "campfire_notify_prefs": nil,
    "campfire_room": nil,
    "irc_keyword": nil,
    "slack_api_token": nil,
    "parallel": 1,
    "github_user": nil,
    "github_permissions": {
        "admin": true,
        "push": true,
        "pull": true
    },
    "irc_server": nil,
    "heroku_deploy_user": nil,
    "dependencies": "",
    "slack_notify_prefs": nil,
    "ssh_keys": [

    ],
    "extra": "",
    "followed": true,
    "branches": {
        "master": {
            "running_builds": [
                {
                    "added_at": "2014-06-05T17:22:52.779Z",
                    "pushed_at": "2014-06-05T17:22:52.518Z",
                    "vcs_revision": "66d398cb635c5f4dd666dd1526bda5894d1246e4",
                    "build_num": 6,
                    "status": "not_running",
                    "outcome": nil
                }
            ]
        }
    },
    "campfire_token": nil,
    "hipchat_notify_prefs": nil,
    "test": "",
    "compile": "",
    "hipchat_room": nil,
    "slack_channel": nil,
    "slack_subdomain": nil,
    "vcs_url": "https://github.com/Shopify/google_auth",
    "flowdock_api_token": nil,
    "hall_room_api_token": nil,
    "slack_webhook_url": nil,
    "irc_username": nil,
    "hipchat_api_token": nil,
    "campfire_subdomain": nil,
    "has_usable_key": true,
    "setup": "",
    "irc_channel": nil,
    "feature_flags": {
        "build_GH1157_container_oriented_ui": nil,
        "set-github-status": true
    },
    "irc_notify_prefs": nil
}
```

#### [set_envvar](#set_envvar)

Endpoint: `/project/:username/:project/envvar`

Creates a new environment variable for a project

```ruby
environment = { name: 'foo', value: 'bar' }
res = CircleCi::Project.set_envvar 'username', 'repo', environment
res.success?
```

Example response

```javascript
{"name":"foo","value":"xxxx"}
```

#### [ssh_key](#ssh_key)

Endpoint: `/project/:username/:repository/ssh-key`

Creates an ssh key that will be used to access the external system identified
by the hostname parameter for SSH key-based authentication.

```ruby
res = CircleCi::Project.ssh_key 'username', 'repo', 'RSA private key', 'hostname'
res.success?
```

Example response

Empty response body with a `200 OK` successful response code
```javascript
""
```

#### [unfollow](#unfollow)

Endpoint: `/project/:username/:repository/unfollow`

Unfollow a project

```ruby
res = CircleCi::Build.unfollow 'username', 'repo'
res.success?
```

Example response

```javascript
{
    "followed": false
}
```

### [Build](#build)

#### [artifacts](#artifacts)

Endpoint: `/project/:username/:repository/:build/artifacts`

Artifacts produced by the build, returns an array of artifact details

```ruby
res = CircleCi::Build.artifacts 'username', 'repo', 'build #'
res.success?
res.body
```

```javascript
[
  {
    node_index: 0,
    path: "/tmp/circle-artifacts.NHQxLku/cherry-pie.png",
    pretty_path: "$CIRCLE_ARTIFACTS/cherry-pie.png",
    url: "https://circleci.com/gh/circleci/mongofinil/22/artifacts/0/tmp/circle-artifacts.NHQxLku/cherry-pie.png"
  },
  {
    node_index: 0,
    path: "/tmp/circle-artifacts.NHQxLku/rhubarb-pie.png",
    pretty_path: "$CIRCLE_ARTIFACTS/rhubarb-pie.png",
    url: "https://circleci.com/gh/circleci/mongofinil/22/artifacts/0/tmp/circle-artifacts.NHQxLku/rhubarb-pie.png"
  }
]
```

#### [cancel](#cancel)

Endpoint: `/project/:username/:repository/:build/cancel`

Cancels the build, returns a summary of the build.

```ruby
res = CircleCi::Build.cancel 'username', 'repo', 'build #'
res.success?
res.body['status'] # 'canceled'
res.body['outcome'] # 'canceled'
res.body['canceled'] # true
```

Example response

```javascript
{
  "vcs_url" : "https://github.com/circleci/mongofinil",
  "build_url" : "https://circleci.com/gh/circleci/mongofinil/26",
  "build_num" : 26,
  "branch" : "master",
  "vcs_revision" : "59c9c5ea3e289f2f3b0c94e128267cc0ce2d65c6",
  "committer_name" : "Allen Rohner",
  "committer_email" : "arohner@gmail.com",
  "subject" : "Merge pull request #6 from dlowe/master"
  "body" : "le bump", // commit message body
  "why" : "retry", // short string explaining the reason we built
  "dont_build" : null, // reason why we didn't build, if we didn't build
  "queued_at" : "2013-05-24T19:37:59.095Z" // time build was queued
  "start_time" : null, // time build started running
  "stop_time" : null, // time build finished running
  "build_time_millis" : null,
  "username" : "circleci",
  "reponame" : "mongofinil",
  "lifecycle" : "queued",
  "outcome" : "canceled",
  "status" : "canceled",
  "canceled" : true,
  "retry_of" : 25, // build_num of the build this is a retry of
  "previous" : { // previous build
    "status" : "success",
    "build_num" : 25
  }
}
```

#### [get](#get)

Endpoint: `/project/:username/:repository/:build`

Full details for a single build, including the output for all actions. The response includes all of the fields from the build summary.

```ruby
res = CircleCi::Build.get 'username', 'repo', 'build #'
res.success?
res.body
```

Example response

```javascript
{
  "vcs_url" : "https://github.com/circleci/mongofinil",
  "build_url" : "https://circleci.com/gh/circleci/mongofinil/22",
  "build_num" : 22,
  "steps" : [ {
    "name" : "configure the build",
    "actions" : [ {
      "bash_command" : null,
      "run_time_millis" : 1646,
      "start_time" : "2013-02-12T21:33:38Z",
      "end_time" : "2013-02-12T21:33:39Z",
      "name" : "configure the build",
      "command" : "configure the build",
      "exit_code" : null,
      "out" : [ ],
      "type" : "infrastructure",
      "index" : 0,
      "status" : "success",
    } ] },
    "name" : "lein2 deps",
    "actions" : [ {
      "bash_command" : "lein2 deps",
      "run_time_millis" : 7555,
      "start_time" : "2013-02-12T21:33:47Z",
      "command" : "((lein2 :deps))",
      "messages" : [ ],
      "step" : 1,
      "exit_code" : 0,
      "out" : [ {
        "type" : "out",
        "time" : "2013-02-12T21:33:54Z",
        "message" : "Retrieving org/clojure ... from clojars\r\n"
      } ],
      "end_time" : "2013-02-12T21:33:54Z",
      "index" : 0,
      "status" : "success",
      "type" : "dependencies",
      "source" : "inference",
      "failed" : null
    } ] },
    "name" : "lein2 trampoline midje",
    "actions" : [ {
      "bash_command" : "lein2 trampoline midje",
      "run_time_millis" : 2310,
      "continue" : null,
      "parallel" : true,
      "start_time" : "2013-02-12T21:33:59Z",
      "name" : "lein2 trampoline midje",
      "command" : "((lein2 :trampoline :midje))",
      "messages" : [ ],
      "step" : 6,
      "exit_code" : 1,
      "out" : [ {
        "type" : "out",
        "time" : "2013-02-12T21:34:01Z",
        "message" : "'midje' is not a task. See 'lein help'.\r\n\r\nDid you mean this?\r\n         do\r\n"
      }, {
        "type" : "err",
        "time" : "2013-02-12T21:34:01Z",
        "message" : "((lein2 :trampoline :midje)) returned exit code 1"
      } ],
      "end_time" : "2013-02-12T21:34:01Z",
      "index" : 0,
      "status" : "failed",
      "timedout" : null,
      "infrastructure_fail" : null,
      "type" : "test",
      "source" : "inference",
      "failed" : true
    } ]
  } ],
}
```

#### [retry](#retry)

Endpoint: `/project/:username/:repository/:build/retry`

Retries the build, returns a summary of the new build.

```ruby
res = CircleCi::Build.retry 'username', 'repo', 'build #'
res.success?
res.body['status'] # 'queued'
res.body
```

Example response

```javascript
{
  "vcs_url" : "https://github.com/circleci/mongofinil",
  "build_url" : "https://circleci.com/gh/circleci/mongofinil/23",
  "build_num" : 23,
  "branch" : "master",
  "vcs_revision" : "1d231626ba1d2838e599c5c598d28e2306ad4e48",
  "committer_name" : "Allen Rohner",
  "committer_email" : "arohner@gmail.com",
  "subject" : "Don't explode when the system clock shifts backwards",
  "body" : "", // commit message body
  "why" : "retry", // short string explaining the reason we built
  "dont_build" : null, // reason why we didn't build, if we didn't build
  "queued_at" : "2013-04-12T21:33:30Z" // time build was queued
  "start_time" : "2013-04-12T21:33:38Z", // time build started running
  "stop_time" : "2013-04-12T21:34:01Z", // time build finished running
  "build_time_millis" : 23505,
  "lifecycle" : "queued",
  "outcome" : null,
  "status" : "queued",
  "retry_of" : 22, // build_num of the build this is a retry of
  "previous" : { // previous build
    "status" : "failed",
    "build_num" : 22
  }
```

#### [tests](#tests)

Endpoint: `/project/:username/:repository/:build/tests`

Tests endpoint to get the recorded tests for a build. Will return an array of
the tests ran and some details.

```ruby
res = CircleCi::Build.tests 'username', 'repo', 'build #'
res.success?
res.body
```

```javascript
[
  {
    "message" => nil,
    "file" => "spec/unit/user_spec.rb",
    "source" => "rspec",
    "run_time" => 0.240912,
    "result" => "success",
    "name" => "user creation",
    "classname"=> "spec.unit.user_spec"
  },
  {
    "message" => "Unable to update user",
    "file" => "spec/unit/user_spec.rb",
    "source"=>"rspec",
    "run_time"=>5.58533,
    "result"=>"failure",
    "name"=>"user update",
    "classname"=>"spec.unit.user_spec"
  }
]
```

### [Recent Builds](#recent_builds)

#### [get](#recent_builds_get)

Endpoint: `/recent-builds`

Build summary for each of the last 30 recent builds, ordered by build_num.

```ruby
res = CircleCi::RecentBuilds.get

# Params of limit and offset can be passed in
# res = CircleCi::RecentBuilds.get limit: 10, offset: 50

res.success?
res.body
```

```javascript
[ {
  "vcs_url" : "https://github.com/circleci/mongofinil",
  "build_url" : "https://circleci.com/gh/circleci/mongofinil/22",
  "build_num" : 22,
  "branch" : "master",
  "vcs_revision" : "1d231626ba1d2838e599c5c598d28e2306ad4e48",
  "committer_name" : "Allen Rohner",
  "committer_email" : "arohner@gmail.com",
  "subject" : "Don't explode when the system clock shifts backwards",
  "body" : "", // commit message body
  "why" : "github", // short string explaining the reason we built
  "dont_build" : null, // reason why we didn't build, if we didn't build
  "queued_at" : "2013-02-12T21:33:30Z" // time build was queued
  "start_time" : "2013-02-12T21:33:38Z", // time build started
  "stop_time" : "2013-02-12T21:34:01Z", // time build finished
  "build_time_millis" : 23505,
  "username" : "circleci",
  "reponame" : "mongofinil",
  "lifecycle" : "finished", // :queued, :scheduled, :not_run, :not_running, :running or :finished
  "outcome" : "failed", // :canceled, :infrastructure_fail, :timedout, :failed, :no_tests or :success
  "status" : "failed", // :retried, :canceled, :infrastructure_fail, :timedout, :not_run, :running, :failed, :queued, :scheduled, :not_running, :no_tests, :fixed, :success
  "retry_of" : null, // build_num of the build this is a retry of
  "previous" : { // previous build
    "status" : "failed",
    "build_num" : 21
  }, ... ]
```

### Tests

Tests are ran using Rspec and VCR for API interaction recording.
Run using `rake` or `rspec`. Please add tests for any new features or
endpoints added if you are contributing. Code styling is enforced with RuboCop
and uses a checked in `.rubocop.yml` for this project.

Tests are using a live CircleCi API token for this repository. Any tests
should be using this key, which is in the `.env` file. You should not have
to do anything outside of writing the tests against this repository.
