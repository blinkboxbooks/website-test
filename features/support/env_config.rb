# ======= Setup Test Config =======
module KnowsAboutConfig
  def require_and_log(lib_array)
    lib_array = [lib_array] if lib_array.class != Array
    lib_array.sort!
    lib_array.each { |file|
      unless $".include?(file.to_s)
        puts("Loading #{file}")
        require_rel(lib_array)
      end
    }
  end

  def load_yaml_file(dir, filename)
    path = "#{dir}/#{filename}"
    YAML.load_file(path)
  end

  def initialise_test_data
    if File.exists?('data/test_data.yml')
      begin
        @_test_data ||= load_yaml_file('data', 'test_data.yml')[TEST_CONFIG['SERVER']]
      rescue
        raise "#{TEST_CONFIG['SERVER']} server is not defined in test_data.yml!"
      end
    else
      raise 'Test data file does not exists!'
    end
  end

  def test_data(data_type, param = nil)
    initialise_test_data
    raise "Unable to find data_type [#{data_type}] in the test data" if @_test_data[data_type.to_s].nil?
    unless param.nil?
      param = param.to_s.gsub(' ', '_').downcase
      raise "Unable to find parameter [#{param}] in the test data set of [#{data_type}]" if @_test_data[data_type.to_s][param].nil?
      @_test_data[data_type.to_s][param]
    else
      @_test_data[data_type.to_s]
    end
  end

  def environments(name)
    @_environments ||= load_yaml_file('config', 'environments.yml')
    env = @_environments[name.upcase]
    raise "Environment '#{name}' is not defined in environments.yml" if env.nil?
    env
  end

  def on?(name)
    !!(name.to_s =~ /^on|true$/i)
  end
end
include KnowsAboutConfig
World(KnowsAboutConfig)

TEST_CONFIG = ENV.to_hash || {}
TEST_CONFIG['debug'] = on?(TEST_CONFIG['DEBUG'])
TEST_CONFIG['fail_fast'] = on?(TEST_CONFIG['FAIL_FAST'])
if TEST_CONFIG['debug']
  ARGV.each do |a|
    puts "Argument: #{a}"
  end
  puts "TEST_CONFIG: #{TEST_CONFIG}"
end

#======== RSpec ======
RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect, :should
  end
end

World(RSpec::Matchers)

#======== Headless Mode ======
if on?(TEST_CONFIG['HEADLESS'])
  puts 'Headless mode.'

  require 'headless'

  headless = Headless.new
  headless.start
end