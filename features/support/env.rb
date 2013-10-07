require 'selenium-webdriver'
require 'capybara'
require 'capybara/dsl'
require 'capybara/cucumber'
require 'active_support/core_ext'
require 'rspec/expectations'
World(RSpec::Matchers)

TEST_CONFIG = {}
TEST_CONFIG["debug"] = !!(ENV["DEBUG"] =~ /^on|true$/i)
puts "TEST_CONFIG: #{TEST_CONFIG}" if TEST_CONFIG["debug"]


Capybara.default_driver = :selenium
Capybara.default_wait_time = 5

#overriding the default native events settings for Selenium.
#This is to make mouse over action working. Without this setting mouse over actions (to activate my account drop down, etc) are not working.
Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app,
                                 :desired_capabilities => {:native_events => false})
end


ARGV.each do |a|
  puts "Argument: #{a}"
end


# target environment
ENV['SERVER'] ||= 'INTEGRATION'
case ENV['SERVER']
  when 'INTEGRATION'
    Capybara.app_host = 'https://nodejs-internal.mobcastdev.com'
  when 'QA'
    Capybara.app_host = 'https://qa.mobcastdev.com'
  when 'STAGING'
    raise "STAGING environment does not exist yet"
  #Capybara.app_host = ''
  when 'PRODUCTION'
    raise "PRODUCTION environment does not exist yet"
  #Capybara.app_host = 'https://www.blinkboxbooks.com'
  else
    Capybara.app_host = 'https://qa.mobcastdev.com'
    raise "Undefined environment name: #{ENV['SERVER']}"

end

# grid setup
if ENV['GRID'] == 'TRUE'

  # target browser
  case ENV['BROWSER_NAME']
    when 'FIREFOX'
      caps = Selenium::WebDriver::Remote::Capabilities.firefox
    when 'SAFARI'
      caps = Selenium::WebDriver::Remote::Capabilities.safari
    when 'INTERNET EXPLORER'
      caps = Selenium::WebDriver::Remote::Capabilities.ie
    when 'CHROME'
      caps = Selenium::WebDriver::Remote::Capabilities.chrome
    when 'HTMLUNIT'
      caps = Selenium::WebDriver::Remote::Capabilities.htmlunit(:javascript_enabled => true)
    else
      caps = Selenium::WebDriver::Remote::Capabilities.firefox
  end

  # target platform
  case ENV['PLATFORM']
    when 'MAC'
      caps.platform = :MAC
    when 'XP'
      caps.platform = :XP
    when 'VISTA'
      caps.platform = :VISTA
    when 'WIN8'
      caps.platform = :WIN8
    when 'WINDOWS' # synonym for Windows 7
      caps.platform = :WINDOWS
    else
      caps.platform = :MAC
  end

  caps.version = ENV['BROWSER_VERSION']
  #Overriding the default native events settings for Selenium.
  #This is to make mouse over action working. Without this setting mouse over actions (to activate my account drop down, etc) are not working.
  caps.native_events=false

  # register the remote driver
  Capybara.register_driver :selenium do |app|
    Capybara::Selenium::Driver.new(app,
                                   :browser => :remote,
                                   :url => "http://selenium.mobcastdev.local:4444/wd/hub",
                                   :desired_capabilities => caps)
  end
end




