require 'net/http'
require 'net/https'
require 'uri'
require 'json'
require 'yaml'
require 'date'
require 'time'
require 'fileutils'
require 'pp'



## our own code
require 'mooncats/graphql/version'    # note: let version always go first
require 'mooncats/graphql/client'
require 'mooncats/graphql/query'




# say hello
puts MooncatsClient.banner
