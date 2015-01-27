require 'logger'

TEST_CONFIG['LOG_LEVEL'] ||= 'INFO'
TEST_CONFIG['log_level'] = TEST_CONFIG['LOG_LEVEL'].to_s.upcase
TEST_CONFIG['log_level'] = 'DEBUG' if TEST_CONFIG['debug']
fail "Not supported LOG LEVEL type '#{TEST_CONFIG['log_level']}'" unless Logger::Severity.constants.include?(TEST_CONFIG['log_level'].to_sym)

module Logging
  class MultiIO
    def self.delegate_all
      IO.methods.each do |m|
        define_method(m) do |*args|
          ret = nil
          @targets.each { |t| ret = t.send(m, *args) }
          ret
        end
      end
    end

    def initialize(*targets)
      @targets = targets
      MultiIO.delegate_all
    end
  end

  class Log
    attr_accessor :logger

    def initialize(level)
      @logger = Logger.new(MultiIO.new(STDOUT))

      @logger.level = Logger.const_get(level.to_s.upcase)
      @logger.datetime_format = '%Y-%m-%d %H:%M:%S'
      @logger.formatter = proc { |severity, datetime, progname, msg| "[#{datetime.to_s.rjust(19)} #{severity.rjust(7)}] #{msg}\n" }
    end
  end

  def logger
    @logger ||= Log.new(TEST_CONFIG['log_level']).logger
  end
end
include Logging
World(Logging)
