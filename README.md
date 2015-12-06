circleci
========

[![Latest Version](https://img.shields.io/gem/v/circleci.svg)](http://rubygems.org/gems/circleci)
[![Circle CI](https://circleci.com/gh/mtchavez/circleci.svg?style=svg)](https://circleci.com/gh/mtchavez/circleci)
[![Code Climate](https://codeclimate.com/github/mtchavez/circleci.png)](https://codeclimate.com/github/mtchavez/circleci)
[![Coverage Status](https://coveralls.io/repos/mtchavez/circleci/badge.png)](https://coveralls.io/r/mtchavez/circleci)

Circle CI API Wrapper

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

Configure using an API token from Circle

```ruby
CircleCi.configure do |config|
  config.token = 'my-token'
end
```

## API Endpoints

* [User](#user)
  * [Me](#me)
* [Project](#project)
  * [All](#all)
  * [Build Branch](#build_branch)
  * [List Checkout Keys](#list_checkout_keys)
  * [Clear Cache](#clear_cache)
  * [Enable](#enable)
  * [Follow](#follow)
  * [Recent Builds Branch](#recent_builds_branch)
  * [Recent Builds](#recent_builds)
  * [Settings](#settings)
  * [Unfollow](#unfollow)
* [Build](#build)
  * [Artifacts](#artifacts)
  * [Cancel](#cancel)
  * [Get](#get)
  * [Retry](#retry)
  * [Tests](#tests)
* [Organization](#organization)

### [User](#user)

#### [me](#me)

Endpoint: `/me`

Provides information about the signed in user.

```ruby
res = CircleCi::User.me
res.success? # True
res.body
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
        "public_key"=>"ssh-rsa key",
        "type"=>"github-user-key",
        "fingerprint"=>"finger_print",
        "login"=>"login",
        "preferred"=>true,
        "time"=>"2015-11-21T16:55:26.922Z"
    },
    {
        "public_key"=>"ssh-rsa key",
        "type"=>"github-user-key",
        "fingerprint"=>"fingerprint",
        "login"=>"anujaware",
        "preferred"=>false,
        "time"=>"2015-11-21T16:48:44.024Z"
    }
]
```

#### [recent_builds](#recent_builds)

Endpoint: `/project/:username/:repository`

Build summary for each of the last 30 recent builds, ordered by build_num.

```ruby
res = CircleCi::Project.recent_builds 'username', 'reponame'
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

### [organization](#organization)

Endpoint: `/organization/:name`

Recent builds for an entire organization

```ruby
res = CircleCi.organization 'my-org'
res.succes?
res.body
```

```javascript
[
   {
      "dont_build":null,
      "committer_name":"Chavez",
      "usage_queued_at":"2014-04-12T10:29:59.352Z",
      "branch":"master",
      "body":"Update Missing ''e'' in CircleCi in README.md",
      "author_date":"2014-03-12T23:14:53Z",
      "node":[
         {
            "username":"ubuntu",
            "ssh_enabled":null,
            "port":64721,
            "public_ip_addr":"54.82.224.94"
         }
      ],
      "committer_date":"2014-03-12T23:14:53Z",
      "compare":null,
      "retries":null,
      "parallel":1,
      "committer_email":"mtchavez@users.noreply.github.com",
      "build_time_millis":16308,
      "why":"retry",
      "author_email":"mtchavez@users.noreply.github.com",
      "ssh_enabled":null,
      "start_time":"2014-04-12T10:29:59.587Z",
      "stop_time":"2014-04-12T10:30:15.895Z",
      "lifecycle":"finished",
      "user":{
         "is_user":true,
         "login":"hwartig",
         "name":"Harald Wartig",
         "email":"hwartig@users.noreply.github.com"
      },
      "subject":"Merge pull request #4 from Alex-Poon/master",
      "messages":[

      ],
      "job_name":null,
      "retry_of":1,
      "previous_successful_build":{
         "build_time_millis":37685,
         "status":"success",
         "build_num":1
      },
      "outcome":"success",
      "status":"success",
      "vcs_revision":"f33617404dc392ddd676fdde87cd5c87369e1857",
      "build_num":2,
      "username":"hwartigcom",
      "vcs_url":"https://github.com/hwartigcom/circleci",
      "timedout":false,
      "previous":{
         "build_time_millis":37685,
         "status":"success",
         "build_num":1
      },
      "canceled":false,
      "infrastructure_fail":false,
      "failed":null,
      "reponame":"circleci",
      "build_url":"https://circleci.com/gh/hwartigcom/circleci/2",
      "feature_flags":{

      },
      "author_name":"Chavez",
      "queued_at":"2014-04-12T10:29:59.517Z"
   },
   {
      "dont_build":null,
      "committer_name":"Chavez",
      "usage_queued_at":"2014-04-08T06:58:09.522Z",
      "branch":"master",
      "body":"Update Missing ''e'' in CircleCi in README.md",
      "author_date":"2014-03-12T23:14:53Z",
      "node":[
         {
            "username":"ubuntu",
            "ssh_enabled":null,
            "port":64775,
            "public_ip_addr":"54.198.9.232"
         }
      ],
      "committer_date":"2014-03-12T23:14:53Z",
      "compare":null,
      "retries":[
         2
      ],
      "parallel":1,
      "committer_email":"mtchavez@users.noreply.github.com",
      "build_time_millis":37685,
      "why":"first-build",
      "author_email":"mtchavez@users.noreply.github.com",
      "ssh_enabled":null,
      "start_time":"2014-04-08T06:58:09.868Z",
      "stop_time":"2014-04-08T06:58:47.553Z",
      "lifecycle":"finished",
      "user":{
         "is_user":true,
         "login":"hwartig",
         "name":"Harald Wartig",
         "email":"hwartig@users.noreply.github.com"
      },
      "subject":"Merge pull request #4 from Alex-Poon/master",
      "messages":[

      ],
      "job_name":null,
      "retry_of":null,
      "previous_successful_build":null,
      "outcome":"success",
      "status":"success",
      "vcs_revision":"f33617404dc392ddd676fdde87cd5c87369e1857",
      "build_num":1,
      "username":"hwartigcom",
      "vcs_url":"https://github.com/hwartigcom/circleci",
      "timedout":false,
      "previous":null,
      "all_commit_details":[
         {
            "committer_name":"Chavez",
            "body":"Update Missing ''e'' in CircleCi in README.md",
            "author_date":"2014-03-12T23:14:53Z",
            "committer_date":"2014-03-12T23:14:53Z",
            "commit_url":"https://github.com/hwartigcom/circleci/commit/f33617404dc392ddd676fdde87cd5c87369e1857",
            "committer_email":"mtchavez@users.noreply.github.com",
            "author_email":"mtchavez@users.noreply.github.com",
            "subject":"Merge pull request #4 from Alex-Poon/master",
            "commit":"f33617404dc392ddd676fdde87cd5c87369e1857",
            "author_name":"Chavez"
         }
      ],
      "canceled":false,
      "infrastructure_fail":false,
      "failed":null,
      "reponame":"circleci",
      "build_url":"https://circleci.com/gh/hwartigcom/circleci/1",
      "feature_flags":{

      },
      "author_name":"Chavez",
      "queued_at":"2014-04-08T06:58:09.739Z"
   }
]
```

### Tests

Tests are ran using Rspec and VCR for API interaction recording.
Run using `rake` or `rspec`. Please add tests for any new features or
endpoints added if you are contributing.

Tests are using a live CircleCi API token for this repository. Any tests
should be using this key, which is in the `.env` file. You should not have
to do anything outside of writing the tests against this repository.
