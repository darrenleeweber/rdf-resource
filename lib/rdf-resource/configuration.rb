
module RDFResource
  class Configuration
    attr_accessor :debug

    attr_accessor :prefixes

    attr_accessor :use_foaf
    attr_accessor :use_schema

    attr_accessor :log_file
    attr_accessor :logger

    def initialize
      @debug = env_boolean('DEBUG')

      # Vocabulary options
      # foaf:Person or schema:Person or both?
      @use_foaf = env_boolean('USE_FOAF')
      @use_schema = env_boolean('USE_SCHEMA') # schema.org

      # RDF prefixes
      @prefixes = {}
      @prefixes['bf'] = 'http://bibframe.org/vocab/'
      @prefixes['foaf'] = 'http://xmlns.com/foaf/0.1/'
      @prefixes['isni'] = 'http://www.isni.org/isni/'
      @prefixes['loc_names'] = 'http://id.loc.gov/authorities/names/'
      @prefixes['loc_subjects'] = 'http://id.loc.gov/authorities/subjects/'
      @prefixes['rdf'] = 'http://www.w3.org/1999/02/22-rdf-syntax-ns#'
      @prefixes['rdfs'] = 'http://www.w3.org/2000/01/rdf-schema#'
      @prefixes['schema'] = 'http://schema.org/'
      @prefixes['owl'] = 'http://www.w3.org/2002/07/owl#'
      @prefixes['viaf'] = 'http://viaf.org/viaf/'

      # logging
      log_file = ENV['RDF_LOG_FILE'] || 'log/rdf-resource.log'
      log_file = File.absolute_path log_file
      @log_file = log_file
      log_path = File.dirname log_file
      unless File.directory? log_path
        # try to create the log directory
        begin
          Dir.mkdir log_path
        rescue
          nil
        end
      end
      begin
        log_file = File.new(@log_file, 'w+')
      rescue
        log_file = $stderr
        @log_file = 'STDERR'
      end
      @logger = Logger.new(log_file, 'monthly')
      @logger.level = @debug ? Logger::DEBUG : Logger::INFO
    end

    def env_boolean(var)
      # check if an ENV variable is true, use false as default

      ENV[var].to_s.upcase == 'TRUE'
    rescue
      false
    end
  end
end
