Zendesk API
------------

The unofficial Ruby Library for interacting with the [Zendesk REST API](http://www.zendesk.com/api)

### Documentation & Requirements
*ActiveResource gem
*Curl
*Curb gem

### What
* Ruby wrapper around the Zendesk REST API

### How
Normal install:
    gem install zendesk-api

Bundler install:
    gem "zendesk-api", "latestversion"


### Using The Zendesk Console

The Zendesk library comes with a convenient console for testing and quick commands (or whatever else you want to use it for).

From /

    irb -r lib/zendesk/console
    z = Zendesk::Main.new('accountname', 'username', 'password')
    z.get_users
