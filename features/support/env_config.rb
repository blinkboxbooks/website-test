# ======= Parse Test Config =======
def on?(name)
  !!(name.to_s =~ /^on|true$/i)
end

TEST_CONFIG = ENV.to_hash || {}
TEST_CONFIG['debug'] = on?(TEST_CONFIG['DEBUG'])
TEST_CONFIG['fail_fast'] = on?(TEST_CONFIG['FAIL_FAST'])
if TEST_CONFIG['debug']
  ARGV.each do |a|
    puts "Argument: #{a}"
  end
  puts "TEST_CONFIG: #{TEST_CONFIG}"
end
TEST_CONFIG['log_js_errors'] ||= false

#======== Load environment specific test data ======
TEST_CONFIG['server'] = TEST_CONFIG['SERVER'].to_s.downcase || 'test'

# ======= Setup Test Config =======
module KnowsAboutTheEnvironment
  def test_data(data_type, param)
    data = test_data_sample(data_type)
    data = data[param.to_s.gsub(' ', '_').downcase]
    fail "Unable to find variable [#{param}] in the test data set of [#{data_type}]" if data.nil?
    data
  end

  def test_data_sample(param)
    initialise_test_data
    data = @_test_data[param.to_s.gsub(' ', '_').downcase]
    fail "Unable to find variable [#{param}] in the test data" if data.nil?
    if data.respond_to?(:sample)
      data.sample
    else
      data
    end
  end

  def server(server_type = 'web')
    uri = test_env.servers[server_type.to_s.downcase]
    fail "'#{server_type}' server URI is not defined for environment '#{TEST_CONFIG['server']}' in config/environments.yml" if uri.nil?
    uri
  end

  private

  def initialise_test_data
    @_test_data ||= @data_dependencies[test_env.data.to_s.upcase]
    fail "Test data '#{test_env.data}' for environment '#{TEST_CONFIG['server']}' is not defined in config/data.yml" if @_test_data.nil?
    @_test_data
  end
end
extend KnowsAboutTheEnvironment
include KnowsAboutTheEnvironment
World(KnowsAboutTheEnvironment)

# ======= load common helpers =======
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

#======== RSpec ======
World(RSpec::Matchers)

#======== Headless Mode ======
if on?(TEST_CONFIG['HEADLESS'])
  puts 'Headless mode.'

  require 'headless'

  headless = Headless.new
  headless.start
end