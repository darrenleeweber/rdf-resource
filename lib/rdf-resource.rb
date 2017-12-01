require 'requires'

# A utility for working with RDF resources and vocabularies
#
# It uses RDF.rb and several RDF::Vocab, with options for
# caching RDF resources.
module RDFResource
  AGENT = RDF::URI.parse('https://rubygems.org/gems/rdf-resource')

  # configuration at the module level, see
  # http://brandonhilkert.com/blog/ruby-gem-configuration-patterns/

  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.reset
    @configuration = Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
