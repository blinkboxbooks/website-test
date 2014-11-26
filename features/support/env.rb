$: << '.'
support_dir = File.join(File.dirname(__FILE__))
path_to_root = support_dir + '/../../'
$LOAD_PATH.unshift File.expand_path(support_dir)

require 'selenium-webdriver'
require 'capybara'
require 'capybara/dsl'
require 'capybara/cucumber'
require 'capybara/angular'
require 'site_prism'
require 'active_support'
require 'active_support/core_ext'
require 'rspec'
require 'rspec/expectations'
require 'rspec/collection_matchers'
require 'benchmark'
require 'yaml'
require 'api_methods.rb'
require 'platform'
require 'cucumber/blinkbox/environment'
require 'cucumber/blinkbox/data_dependencies'

TEST_CONFIG = ENV.to_hash || {}
TEST_CONFIG['debug'] = !!(TEST_CONFIG['DEBUG'] =~ /^on|true$/i)
TEST_CONFIG['fail_fast'] = !!(TEST_CONFIG['FAIL_FAST'] =~ /^on|true$/i)
if TEST_CONFIG['debug']
  ARGV.each do |a|
    puts "Argument: #{a}"
  end
  puts "TEST_CONFIG: #{TEST_CONFIG}"
end

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
  lib_array.each do |file|
    unless $".include?(file.to_s)
      puts("Loading #{file}") if TEST_CONFIG['debug']
      require file.to_s
    end
  end
end

puts 'Loading custom cucumber formatters...'
require_and_log Dir[File.join(support_dir, 'formatter', '*.rb')]

puts 'Loading support files...'
require_and_log Dir[File.join(support_dir, 'core_ruby_overrides.rb')]
require_and_log Dir[File.join(support_dir, '*.rb')]

puts 'Loading page models...'
require_and_log Dir[File.join(support_dir, 'page_models', '*.rb')]
require_and_log Dir[File.join(support_dir, 'page_models/sections', 'blinkboxbooks_section.rb')]
require_and_log Dir[File.join(support_dir, 'page_models/sections', '*.rb')]
require_and_log Dir[File.join(support_dir, 'page_models/pages', 'blinkboxbooks_page.rb')]
require_and_log Dir[File.join(support_dir, 'page_models/pages', '*.rb')]

# ======= Setup PATH env. variable =======
puts "RUBY_PLATFORM: #{RUBY_PLATFORM}"

case Platform::OS
when :win32
  separator = ";"
  current_os = 'win'
when :unix
  separator = ":"
  if Platform::IMPL == :macosx
    current_os = 'mac'
  else
    current_os = 'unix'
  end
else
  fail "Current OS is not supported by ChromeDriver and/or BrowserStack Local (OS: #{Platform::OS}, Implementation: #{Platform::IMPL}):\r\n- http://code.google.com/p/chromium/downloads/list\r\n- http://www.browserstack.com/local-testing#command-line"
end

chromedriver_path = File.expand_path File.join(path_to_root, 'lib', 'chromedrv', current_os)
browserstack_path = File.expand_path File.join(path_to_root, 'lib', 'browserstacklocal', current_os)

ENV["PATH"] = "#{browserstack_path}#{separator}#{chromedriver_path}#{separator}#{ENV["PATH"]}"

# ======= Setup target environment =======
Capybara.app_host = server('web')

# ======== set up browser driver =======
# Capybara browser driver settings
Capybara.default_driver = :selenium
Capybara.default_wait_time = 10
World(Capybara::Angular::DSL)

# target browser
TEST_CONFIG['BROWSER_NAME'] ||= 'chrome'
TEST_CONFIG['BROWSER_NAME'] = 'ie' if TEST_CONFIG['BROWSER_NAME'].downcase == 'internet explorer'
if TEST_CONFIG['GRID'] =~ /browserstack/i
  caps = Selenium::WebDriver::Remote::Capabilities.new
else
  caps = case TEST_CONFIG['BROWSER_NAME'].downcase
         when 'firefox', 'safari', 'ie', 'chrome', 'android'
           browser_name = TEST_CONFIG['BROWSER_NAME'].downcase.to_sym
           Selenium::WebDriver::Remote::Capabilities.send(TEST_CONFIG['BROWSER_NAME'].downcase.to_sym)
           #TODO: investigate and introduce a reliable headless driver for blinkboxbooks webstie testing
           #when 'htmlunit', 'webkit', 'poltergeist' #headless mode
           #  Selenium::WebDriver::Remote::Capabilities.htmlunit(:javascript_enabled => true)
         else
           fail "Not supported browser: #{TEST_CONFIG['BROWSER_NAME']}"
         end

  caps.version = TEST_CONFIG['BROWSER_VERSION']
end

# Overriding the default native events settings for Selenium.
# This is to make mouse over action working. Without this setting mouse over actions (to activate my account drop down, etc) are not working.
caps.native_events = false

# grid setup
if TEST_CONFIG['GRID'] =~ /^true|on$/i
  # target platform
  TEST_CONFIG['PLATFORM'] ||= 'FIRST_AVAILABLE'
  case TEST_CONFIG['PLATFORM'].upcase
  when 'MAC', 'XP', 'VISTA', 'WIN8', 'WINDOWS', 'LINUX' # *WINDOWS* stands for Windows 7
    TEST_CONFIG['GRID_HUB_IP'] ||= '172.17.51.12'
    caps.platform = TEST_CONFIG['PLATFORM'].upcase.to_sym
  when 'ANDROID'
    TEST_CONFIG['GRID_HUB_IP'] ||= 'localhost'
    caps.platform = TEST_CONFIG['PLATFORM'].downcase.to_sym
  when 'FIRST_AVAILABLE'
    TEST_CONFIG['GRID_HUB_IP'] ||= '172.17.51.12'
    #do not set caps.platform, in order to force selenium grid hub to pick up the first available node,
    #which matches other specified capabilities. NB nodes are ordered by the order of registration with the hub.
  else
    fail "Not supported platform: #{TEST_CONFIG['PLATFORM']}"
  end

  # register the remote driver
  grid_url = "http://#{TEST_CONFIG['GRID_HUB_IP']}:4444/wd/hub"
  Capybara.register_driver :selenium do |app|
    Capybara::Selenium::Driver.new(app,
                                   :browser => :remote,
                                   :url => grid_url,
                                   :desired_capabilities => caps)
  end

elsif TEST_CONFIG['GRID'] =~ /browserstack/i
  # Default values
  TEST_CONFIG['BROWSER_NAME'] ||= 'chrome'
  TEST_CONFIG['BROWSER_VERSION'] ||= '30.0'
  TEST_CONFIG['OS'] ||= 'Windows'
  TEST_CONFIG['OS_VERSION'] ||= '7'

  # TODO: Logger
  puts "-- BrowserStack settings --"
  puts "Browser name: #{TEST_CONFIG['BROWSER_NAME']}"
  puts "Browser version: #{TEST_CONFIG['BROWSER_VERSION']}"
  puts "OS: #{TEST_CONFIG['OS']}"
  puts "OS version: #{TEST_CONFIG['OS_VERSION']}"

  caps["browser"] = TEST_CONFIG['BROWSER_NAME']
  caps["browser_version"] = TEST_CONFIG['BROWSER_VERSION']
  caps["os"] = TEST_CONFIG['OS']
  caps["os_version"] = TEST_CONFIG['OS_VERSION']
  caps["browserstack.debug"] = "true"
  caps["name"] = TEST_CONFIG['BROWSERSTACK_SESSION_TITLE'].nil? ? "Untitled BrowserStack session" : TEST_CONFIG['BROWSERSTACK_SESSION_TITLE']
  caps["project"] = TEST_CONFIG['BROWSERSTACK_PROJECT'].nil? ? "on_demand" : TEST_CONFIG['BROWSERSTACK_PROJECT']
  caps["build"] = TEST_CONFIG['BROWSERSTACK_BUILD'] unless TEST_CONFIG['BROWSERSTACK_BUILD'].nil?
  caps["browserstack.debug"] = "false"
  TEST_CONFIG['BROWSERSTACK_USERNAME'] ||= "gabormajor1"
  TEST_CONFIG['BROWSERSTACK_KEY'] ||= "SwqrhidMjGruyCtdCmx8"

  # Check BrowserStack availability
  fail 'No more parallel sessions available!' unless APIMethods::Browserstack.new(TEST_CONFIG['BROWSERSTACK_USERNAME'], TEST_CONFIG['BROWSERSTACK_KEY']).session_available?
  fail 'The specified project does not exists in BrowserStack!' unless APIMethods::Browserstack.new(TEST_CONFIG['BROWSERSTACK_USERNAME'], TEST_CONFIG['BROWSERSTACK_KEY']).project_exists?(TEST_CONFIG['BROWSERSTACK_PROJECT'])
  fail 'Not supported BrowserStack capabilities!' unless APIMethods::Browserstack.new(TEST_CONFIG['BROWSERSTACK_USERNAME'], TEST_CONFIG['BROWSERSTACK_KEY']).valid_capabilities?(TEST_CONFIG['BROWSER_NAME'], TEST_CONFIG['BROWSER_VERSION'], TEST_CONFIG['OS'], TEST_CONFIG['OS_VERSION'])

  if TEST_CONFIG['SERVER'] == "PRODUCTION"
    caps["browserstack.local"] = "false"
  else
    caps["browserstack.local"] = "true"
    # Running tunneling binary as background process
    $browser_stack_tunnel = BrowserstackUtilities::BrowserstackTunnel.new(TEST_CONFIG['BROWSERSTACK_KEY'], environments(TEST_CONFIG['SERVER']))
    $browser_stack_tunnel.start
  end

  grid_url = "http://#{TEST_CONFIG['BROWSERSTACK_USERNAME']}:#{TEST_CONFIG['BROWSERSTACK_KEY']}@hub.browserstack.com/wd/hub"

  # register the remote driver
  Capybara.register_driver :selenium do |app|
    Capybara::Selenium::Driver.new(app,
                                   :browser => :remote,
                                   :url => grid_url,
                                   :desired_capabilities => caps)
  end

else
  # register local browser driver
  Capybara.register_driver :selenium do |app|
    Capybara::Selenium::Driver.new(app,
                                   :browser => browser_name,
                                   :desired_capabilities => caps)
  end

end

# Headless mode
if TEST_CONFIG['HEADLESS'] =~ /^true|on$/i
  puts 'Headless mode.'

  require 'headless'

  headless = Headless.new
  headless.start
end
