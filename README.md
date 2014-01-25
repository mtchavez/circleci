circleci
========

[![Build Status](https://travis-ci.org/mtchavez/circleci.png)](https://travis-ci.org/mtchavez/circleci)
[![endorse](http://api.coderwall.com/mtchavez/endorsecount.png)](http://coderwall.com/mtchavez)

Circle CI API Wrapper

## Install

```ruby
gem install 'circleci'
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

### User

#### CircleCi::User.me

Provides information about the signed in user.

```ruby
res = CircleCi::User.me
res.succes? # True
res.body
```

Example response

```json
{
  "basic_email_prefs" : "smart", // can be "smart", "none" or "all"
  "login" : "pbiggar" // your github username
}
```

### Project

#### CircleCi::Project.all

List of all the repos you have access to on Github, with build information organized by branch.

```ruby
res = CircleCi::Project.all
res.success?
res.body
```

Example response

```json
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

#### CircleCi::Project.recent_builds

Build summary for each of the last 30 recent builds, ordered by build_num.

```ruby
res = CirclCi::Project.recent_builds 'username', 'reponame'
res.success?
res.body
```

Example response

```json
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

#### CircleCi::Project.recent_builds_branch

Build summary for each of the last 30 recent builds for a specific branch, ordered by build_num.

```ruby
res = CirclCi::Project.recent_builds_branch 'username', 'reponame', 'branch'
res.success?
res.body
```

Example response

```json
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

#### CircleCi::Project.clear_cache

Clears the cache for a project

```ruby
res = CircleCi::Project.clear_cache
res.body['status']
```

Example response

```json
{
  "status" : "build caches deleted"
}
```

### Build

#### CircleCi::Build.get

Full details for a single build, including the output for all actions. The response includes all of the fields from the build summary.

```ruby
res = CircleCi::Build.get 'username', 'repo', 'build #'
res.success?
res.body
```

Example response

```json
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

#### CircleCi::Build.retry

Retries the build, returns a summary of the new build.

```ruby
res = CircleCi::Build.retry 'username', 'repo', 'build #'
res.success?
res.body['status'] # 'queued'
res.body
```

Example response

```json
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
#### CircleCi::Build.artifacts

Artifacts produced by the build, returns an array of artifact details

```ruby
res = CircleCi::Build.artifacts 'username', 'repo', 'build #'
res.success?
res.body
```

```json
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

### Tests

Run using ```rake```

## License

Written by Chavez

Released under the MIT License: http://www.opensource.org/licenses/mit-license.php
