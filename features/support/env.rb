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

World(RSpec::Matchers)

# ======= Setup Test Config =======
TEST_CONFIG = ENV.to_hash || {}
TEST_CONFIG["debug"] = !!(TEST_CONFIG["DEBUG"] =~ /^on|true$/i)
puts "TEST_CONFIG: #{TEST_CONFIG}" if TEST_CONFIG["debug"]

# ======= Setup target environment =======
#TODO: move into config/environments.yml once more environments are added
environments = {
    'NODEJS-INTERNAL' => 'https://nodejs-internal.mobcastdev.com',
    'QA' => 'https://qa.mobcastdev.com',
    'STAGING' => nil,
    'PRODUCTION' => 'https://www.blinkboxbooks.com'
}
TEST_CONFIG['SERVER'] ||= 'QA'
raise "Environment is not supported: #{TEST_CONFIG['SERVER']}" if environments[TEST_CONFIG['SERVER'].upcase].nil?
Capybara.app_host = environments[TEST_CONFIG['SERVER'].upcase]

# ======= load common helpers =======
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

puts "Loading custom cucumber formatters..."
require_and_log Dir[File.join(support_dir, 'formatters', '*.rb')]

puts "Loading support files..."
require_and_log Dir[File.join(support_dir, 'core_ruby_overrides.rb')]

puts "Loading page models..."
require_and_log Dir[File.join(support_dir, 'page_models', '*.rb')]
require_and_log Dir[File.join(support_dir, 'page_models/sections', '*.rb')]
require_and_log Dir[File.join(support_dir, 'page_models/pages', '*.rb')]

ARGV.each do |a|
  puts "Argument: #{a}"
end

# ======== set up browser driver =======
# Capybara browser driver settings
Capybara.default_driver = :selenium
Capybara.default_wait_time = 10

# target browser
TEST_CONFIG['BROWSER_NAME'] ||= 'firefox'
TEST_CONFIG['BROWSER_NAME'] = 'ie' if TEST_CONFIG['BROWSER_NAME'].downcase == 'internet explorer'
caps = case TEST_CONFIG['BROWSER_NAME'].downcase
         when 'firefox', 'safari', 'ie', 'chrome'
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

  # target platform
  TEST_CONFIG['PLATFORM'] ||= 'MAC'
  caps.platform = case TEST_CONFIG['PLATFORM'].upcase
                    when 'MAC', 'XP', 'VISTA', 'WIN8', 'WINDOWS' # *WINDOWS* stands for Windows 7
                      TEST_CONFIG['PLATFORM'].upcase.to_sym
                    else
                      raise "Not supported platform: #{TEST_CONFIG['PLATFORM']}"
                  end

  # register the remote driver
  Capybara.register_driver :selenium do |app|
    Capybara::Selenium::Driver.new(app,
                                   :browser => :remote,
                                   :url => "http://selenium.mobcastdev.local:4444/wd/hub",
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