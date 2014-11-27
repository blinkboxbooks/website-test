# ======= Setup Test Config =======
module KnowsAboutTheEnvironment
  path_to_root = File.dirname(__FILE__) + '/../../'
  $LOAD_PATH.unshift File.expand_path(path_to_root)

  def require_and_log(lib_array)
    lib_array = [lib_array] if lib_array.class != Array
    lib_array.sort!
    lib_array.each { |file|
      unless $".include?(file.to_s)
        puts("Loading #{file}") if TEST_CONFIG['debug']
        require_rel(lib_array)
      end
    }
  end

  def test_data(data_type, param)
    initialise_test_data
    param = param.to_s.gsub(' ', '_').downcase
    raise "Unable to find data_type [#{data_type}] in the test data" if @_test_data[data_type.to_s].nil?
    raise "Unable to find parameter [#{param}] in the test data set of [#{data_type}]" if @_test_data[data_type.to_s][param].nil?
    @_test_data[data_type.to_s][param]
  end

  def test_list(data)
    initialise_test_data
    raise "Unable to find data_type [#{data}] in the test data" if @_test_data[data.to_s].nil?
    @_test_data[data.to_s]
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

  private

  def load_yaml_file(dir, filename)
    path = "#{dir}/#{filename}"
    YAML.load_file(path)
  end

  def initialise_test_data
    @_test_data ||= load_yaml_file('data', 'test_data.yml')[TEST_CONFIG['SERVER']]
  end
end
extend KnowsAboutTheEnvironment
include KnowsAboutTheEnvironment
World(KnowsAboutTheEnvironment)

TEST_CONFIG = ENV.to_hash || {}
TEST_CONFIG['debug'] = !!(TEST_CONFIG['DEBUG'] =~ /^on|true$/i)
TEST_CONFIG['fail_fast'] = !!(TEST_CONFIG['FAIL_FAST'] =~ /^on|true$/i)
if TEST_CONFIG['debug']
  ARGV.each do |a|
    puts "Argument: #{a}"
  end
  puts "TEST_CONFIG: #{TEST_CONFIG}"
end
TEST_CONFIG['log_js_errors'] ||= false

#======== RSpec ======
World(RSpec::Matchers)

#======== Headless Mode ======
if on?(TEST_CONFIG['HEADLESS'])
  puts 'Headless mode.'

  require 'headless'

  headless = Headless.new
  headless.start
end