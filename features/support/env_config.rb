# ======= Setup Test Config =======
TEST_CONFIG = ENV.to_hash || {}
TEST_CONFIG['server'] = TEST_CONFIG['SERVER'].to_s.downcase || 'test'

module KnowsAboutTheEnvironment
  def test_data(data_type, param)
    data = test_data_sample(data_type)
    data = data[param.to_s.gsub(' ', '_').downcase]
    fail "Unable to find variable [#{param}] in the test data set of [#{data_type}]" if data.nil?
    data
  end

  def test_data_sample(param)
    initialise_test_data
    data = @@_test_data[param.to_s.gsub(' ', '_').downcase]
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
    @@_test_data ||= @data_dependencies[test_env.data.to_s.upcase]
    if @@_test_data.nil?
      fail "Test data '#{test_env.data}' for environment '#{TEST_CONFIG['server']}' is not defined in config/data.yml"
    end
    @@_test_data
  end

  def config_flag_on?(name)
    !!(name.to_s =~ /^on|true$/i)
  end
end

extend KnowsAboutTheEnvironment
include KnowsAboutTheEnvironment
World(KnowsAboutTheEnvironment)

# ======== Load environment specific test data ======
extend KnowsAboutDataDependencies
initialise_test_data # initialise test data in order to fail fast, if config is incorrect or data is missing

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

TEST_CONFIG['debug'] = config_flag_on?(TEST_CONFIG['DEBUG'])
TEST_CONFIG['fail_fast'] = config_flag_on?(TEST_CONFIG['FAIL_FAST'])
TEST_CONFIG['js_log'] ||= config_flag_on?(TEST_CONFIG['JS_LOG'])
if TEST_CONFIG['debug']
  ARGV.each { |a| puts "Argument: #{a}" }
  puts "TEST_CONFIG: #{TEST_CONFIG}"
end

# ======= load common helpers =======
puts 'Loading custom cucumber formatters...'
require_and_log 'formatter/*.rb'

puts 'Loading support files...'
require_and_log 'core_ruby_overrides.rb'
require_and_log '*.rb'

puts 'Loading page models...'
require_and_log 'page_models/*.rb'
require_and_log 'page_models/sections/blinkboxbooks_section.rb'
require_and_log 'page_models/sections/*.rb'
require_and_log 'page_models/pages/blinkboxbooks_page.rb'
require_and_log 'page_models/pages/*.rb'
