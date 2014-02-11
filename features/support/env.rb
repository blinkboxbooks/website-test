$: << "."
support_dir = File.join(File.dirname(__FILE__))
$LOAD_PATH.unshift File.expand_path(support_dir)

require 'selenium-webdriver'
require 'capybara'
require 'capybara/dsl'
require 'capybara/cucumber'
require 'site_prism'
require 'active_support/core_ext'
require 'rspec/expectations'
require 'active_support'
require 'benchmark'
require 'yaml'
require "multi_json"
require "httpclient"

World(RSpec::Matchers)

# ======= Setup Test Config =======
module KnowsAboutConfig
  path_to_root = File.dirname(__FILE__) + '/../../'
  $LOAD_PATH.unshift File.expand_path(path_to_root)

  def require_and_log(lib_array)
    lib_array = [lib_array] if lib_array.class != Array
    lib_array.sort!
    lib_array.each { |file|
      if !$".include?(file.to_s)
        puts("Loading #{file}") if TEST_CONFIG["debug"]
        require file.to_s
      end
    }
  end

  def load_yaml_file(dir, filename)
    path = "#{dir}/#{filename}"
    YAML.load_file(path)
  end

  def initialise_test_data
    @_test_data ||= load_yaml_file("data", "test_data.yml")
  end

  def test_data(data_type, param)
    initialise_test_data
    param = param.to_s.gsub(' ', '_').downcase
    raise "Unable to find data_type [#{data_type}] in the test data" if @_test_data[data_type.to_s].nil?
    raise "Unable to find parameter [#{param}] in the test data set of [#{data_type}]" if @_test_data[data_type.to_s][param].nil?
    @_test_data[data_type.to_s][param]
  end

  def environments(name)
    @_environments ||= load_yaml_file("config", "environments.yml")
    env = @_environments[name.upcase]
    raise "Environment '#{name}' is not defined in environments.yml" if env.nil?
    env
  end
end
include KnowsAboutConfig
World(KnowsAboutConfig)
initialise_test_data

TEST_CONFIG = ENV.to_hash || {}
TEST_CONFIG["debug"] = !!(TEST_CONFIG["DEBUG"] =~ /^on|true$/i)
TEST_CONFIG["fail_fast"] = !!(TEST_CONFIG["FAIL_FAST"] =~ /^on|true$/i)
if TEST_CONFIG["debug"]
  ARGV.each do |a|
    puts "Argument: #{a}"
  end
  puts "TEST_CONFIG: #{TEST_CONFIG}"
end

# ======= Setup target environment =======

TEST_CONFIG['SERVER'] ||= 'QA'
Capybara.app_host = environments(TEST_CONFIG['SERVER'].upcase)

# ======= load common helpers =======

puts "Loading custom cucumber formatters..."
require_and_log Dir[File.join(support_dir, 'formatters', '*.rb')]

puts "Loading support files..."
require_and_log Dir[File.join(support_dir, 'core_ruby_overrides.rb')]

puts "Loading page models..."
require_and_log Dir[File.join(support_dir, 'page_models', '*.rb')]
require_and_log Dir[File.join(support_dir, 'page_models/sections', 'blinkboxbooks_section.rb')]
require_and_log Dir[File.join(support_dir, 'page_models/sections', '*.rb')]
require_and_log Dir[File.join(support_dir, 'page_models/pages', 'blinkboxbooks_page.rb')]
require_and_log Dir[File.join(support_dir, 'page_models/pages', '*.rb')]

# ======== set up browser driver =======
# Capybara browser driver settings
Capybara.default_driver = :selenium
Capybara.default_wait_time = 10

# target browser
TEST_CONFIG['BROWSER_NAME'] ||= 'firefox'
TEST_CONFIG['BROWSER_NAME'] = 'ie' if TEST_CONFIG['BROWSER_NAME'].downcase == 'internet explorer'
caps = case TEST_CONFIG['BROWSER_NAME'].downcase
         when 'firefox', 'safari', 'ie', 'chrome', 'android'
           browser_name = TEST_CONFIG['BROWSER_NAME'].downcase.to_sym
           Selenium::WebDriver::Remote::Capabilities.send(TEST_CONFIG['BROWSER_NAME'].downcase.to_sym)
         #TODO: investigate and introduce a reliable headless driver for blinkboxbooks webstie testing
         #when 'htmlunit', 'webkit', 'poltergeist' #headless mode
         #  Selenium::WebDriver::Remote::Capabilities.htmlunit(:javascript_enabled => true)
         else
           raise "Not supported browser: #{TEST_CONFIG['BROWSER_NAME']}"
       end

caps.version = TEST_CONFIG['BROWSER_VERSION']

# Overriding the default native events settings for Selenium.
# This is to make mouse over action working. Without this setting mouse over actions (to activate my account drop down, etc) are not working.
caps.native_events=false

# grid setup
if TEST_CONFIG['GRID'] =~ /^true|on$/i
  remote_url = "http://selenium.mobcastdev.local:4444/wd/hub"
  # target platform
  TEST_CONFIG['PLATFORM'] ||= 'MAC'
  caps.platform = case TEST_CONFIG['PLATFORM'].upcase
                    when 'MAC', 'XP', 'VISTA', 'WIN8', 'WINDOWS' # *WINDOWS* stands for Windows 7
                      TEST_CONFIG['PLATFORM'].upcase.to_sym
                    when 'ANDROID'
                      TEST_CONFIG['PLATFORM'].downcase.to_sym
                      remote_url = "http://localhost:4444/wd/hub"
                    else
                      raise "Not supported platform: #{TEST_CONFIG['PLATFORM']}"
                  end
  # register the remote driver
  Capybara.register_driver :selenium do |app|
    Capybara::Selenium::Driver.new(app,
                                   :browser => :remote,
                                   :url => remote_url,
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