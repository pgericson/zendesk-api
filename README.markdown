Zendesk API
------------

The unofficial Ruby Library for interacting with the [Zendesk REST API](http://www.zendesk.com/api)

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

## How to use it
### Basic
Below outputs xml
    z = Zendesk::Main.new('subdomain', 'username', 'password')
and outputs json
    z = Zendesk::Main.new('subdomain', 'username', 'password', :format => 'json')

For the most part all functions is based on the following functions
REST function_names = %{user, organization, group, ticket,attachement, tag, forum, entries, search}

### Show
    z.get_function_name(user_id)
e.g.
    z.get_user(121)
### List
    z.get_function_names #with a s in the end, for plural
e.g.
    z.get_users

### Create
with string
    z.create_function_name("<user><email>email@company.com</email><name>John Doe</name></user>")
with hash(array is not supported yet)
    z.create_function_name({:email => 'email@company.com', :name => 'John Doe'})

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
