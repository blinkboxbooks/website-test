require 'logger'

TEST_CONFIG['LOG_LEVEL'].nil? || !Logger::Severity.constants.include?(TEST_CONFIG['LOG_LEVEL'].upcase.to_sym) ? TEST_CONFIG['LOG_LEVEL'] = 'INFO' : TEST_CONFIG['LOG_LEVEL'] = TEST_CONFIG['LOG_LEVEL'].upcase

module Logging
  class Log
    attr_accessor :logger

    def initialize
      @logger = Logger.new(STDOUT)

      @logger.level = Logger.const_get(TEST_CONFIG['LOG_LEVEL'].upcase)
      @logger.datetime_format = '%Y-%m-%d %H:%M:%S'
      @logger.formatter = proc { |severity, datetime, progname, msg| "[#{datetime.to_s.rjust(19)} #{severity.rjust(7)}] #{msg}\n" }
      @logger.info("Logging level: #{TEST_CONFIG['LOG_LEVEL'].upcase}")
    end
  end

  def logger
    @logger ||= Log.new.logger
  end
end
include Logging
World(Logging)