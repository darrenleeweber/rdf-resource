
module RDFResource

  class Configuration

    attr_accessor :debug
    attr_accessor :logger

    def initialize
      @debug = env_boolean('DEBUG')

      # logger
      log_file = ENV['RDF_LOG_FILE'] || 'log/rdf_resource.log'
      log_file = File.absolute_path log_file
      @log_file = log_file
      log_path = File.dirname log_file
      unless File.directory? log_path
        # try to create the log directory
        Dir.mkdir log_path rescue nil
      end
      begin
        log_dev = File.new(@log_file, 'w+')
      rescue
        log_dev = $stderr
        @log_file = 'STDERR'
      end
      log_dev.sync = true if @debug # skip IO buffering in debug mode
      @logger = Logger.new(log_dev, 'monthly')
      @logger.level = @debug ? Logger::DEBUG : Logger::INFO

    end

    def env_boolean(var)
      # check if an ENV variable is true, use false as default
      ENV[var].to_s.upcase == 'TRUE' rescue false
    end

  end

end
