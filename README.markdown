THIS GEM IS DEPRECATED!!!
------------
USE THE OFFICIAL GEM FROM ZENDESK
------------
[zendesk_api gem from zendesk](https://github.com/zendesk/zendesk_api_client_rb)
------------


THIS GEM WILL NOT BE UPDATED
------------

old documentation below

Zendesk API
------------

The unofficial Ruby Library for interacting with the [Zendesk REST API](http://www.zendesk.com/api)

Looking for a new head maintainer, since I do not use zendesk anymore.

## Documentation & Requirements
 * ActiveResource gem
 * Curl
 * Curb gem

## What
* Ruby wrapper around the Zendesk REST API

## Install Instructions
Normal install:

    gem install zendesk-api

Bundler install:

    gem "zendesk-api", "latestversion"

## Supported v1 Endpoints

* Attachments
* Comments
* Entries
* Forums
* Groups
* Organizations
* Search
* Tags
* Tickets
* Users

## How to use it
### Basic
Below outputs xml

    z = Zendesk::Main.new('subdomain', 'username', 'password')
and outputs json

    z = Zendesk::Main.new('subdomain', 'username', 'password', :format => 'json')

### Show

    z.get_function_name(user_id)

where function_name is one the following:
user, organization, group, ticket, attachement, tag, forum, entries, search

e.g.

    z.get_user(121)
### List

    z.get_function_names #with a s in the end, for plural
e.g.

    z.get_users

### Create
with string

    z.create_user("<user><email>email@company.com</email><name>John Doe</name></user>")
with hash(array is not supported yet)

    z.create_user({:email => 'email@company.com', :name => 'John Doe'})

### Update
Not supported yet

### Destroy

    z.destroy_function_name(id)
e.g.

    z.destroy_user(234)


## Using The Zendesk Console

The Zendesk library comes with a convenient console for testing and quick commands (or whatever else you want to use it for).

From /

    irb -r lib/zendesk/console
    z = Zendesk::Main.new('accountname', 'username', 'password')
    z.get_users

## License

The Zendesk library is released under the MIT license:

* http://www.opensource.org/licenses/MIT
