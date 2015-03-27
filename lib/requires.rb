require 'dotenv'
Dotenv.load

require 'pry'
require 'pry-doc'

# Using rest-client with options to enable a client HTTP cache
require 'rest-client'
RestClient.proxy = ENV['http_proxy'] unless ENV['http_proxy'].nil?
RestClient.proxy = ENV['HTTP_PROXY'] unless ENV['HTTP_PROXY'].nil?
if ENV['RDF_CACHE_ENABLED'].to_s.upcase == 'TRUE'
  require 'dalli'
  require 'restclient/components'
  require 'rack/cache'
  # TODO: use RDF_CACHE_LOG_FILE || STDOUT
  RestClient.enable Rack::CommonLogger, STDOUT
  # Enable the HTTP cache to store meta and entity data according
  # to the env config values or the defaults given here.  See
  # http://rtomayko.github.io/rack-cache/configuration for available options.
  metastore = ENV['RDF_CACHE_METASTORE'] || 'file:/tmp/cache/rdf_meta'
  entitystore = ENV['RDF_CACHE_ENTITYSTORE'] || 'file:/tmp/cache/rdf_body'
  verbose = ENV['RDF_CACHE_VERBOSE'].to_s.upcase == 'TRUE' || false
  RestClient.enable Rack::Cache,
    metastore: metastore,
    entitystore: entitystore,
    default_ttl: 86400, # when to recheck, in seconds (daily = 60 x 60 x 24)
    verbose: verbose
end

require 'addressable/uri'
require 'json'
require 'uuid'

require 'linkeddata'
require 'rdf/iiif'
require 'rdf-vocab'
require_relative 'rdf/vocab/Content.rb'
require_relative 'rdf/vocab/sc.rb'

require_relative 'rdf-resource/configuration'
require_relative 'rdf-resource/resource'

