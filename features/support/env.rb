require 'capybara'
require 'capybara/dsl'
require 'capybara/cucumber'
require 'selenium-webdriver'

Capybara.default_driver = :selenium
Capybara.default_wait_time = 5


# target environment
case ENV['TEST_ENV']
	when 'int', 'integration', 'INTEGRATION'
			Capybara.app_host = 'https://nodejs-internal.mobcastdev.com'
	when 'qa', 'QA'
			Capybara.app_host = 'https://nodejs-internal.mobcastdev.com'
	when 'staging', 'STAGING'
			Capybara.app_host = 'https://nodejs-internal.mobcastdev.com'
	when 'live', 'LIVE', 'PROD', 'PRODUCTION'
			Capybara.app_host = 'https://www.blinkboxmusic.com'
	else 
			Capybara.app_host = 'https://nodejs-internal.mobcastdev.com'
end

# grid setup
if ENV['GRID'] == 'true'

	# target browser
	case ENV['BROWSER_NAME']
	 	when 'firefox', 'Firefox', 'FIREFOX'
			caps = Selenium::WebDriver::Remote::Capabilities.firefox
 		when 'safari', 'Safari', 'SAFARI'
			caps = Selenium::WebDriver::Remote::Capabilities.safari
	 	when 'ie', 'internet explorer', 'INTERNET EXPLORER'
			caps = Selenium::WebDriver::Remote::Capabilities.ie
 		when 'chrome', 'Chrome', 'CHROME'
			caps = Selenium::WebDriver::Remote::Capabilities.chrome
		when 'htmlunit', 'HTMLUNIT'
			caps = Selenium::WebDriver::Remote::Capabilities.htmlunit(:javascript_enabled => true)
		else 
			caps = Selenium::WebDriver::Remote::Capabilities.firefox
	end

	# target platform
	case ENV['PLATFORM']
		when 'mac', 'MAC', 'OSX'
			caps.platform = :MAC
		when 'xp', 'XP'
			caps.platform = :XP
		when 'vista', 'VISTA'
			caps.platform = :VISTA
		when 'win8', 'WIN8'
			caps.platform = :WIN8
		when 'windows', 'WINDOWS' # synonym for Windows 7
			caps.platform = :WINDOWS
		else 	
			caps.platform = :MAC
	end 

	caps.version = ENV['BROWSER_VERSION']

	# register the remote driver
	Capybara.register_driver :selenium do |app|
  		Capybara::Selenium::Driver.new(app,
    	:browser => :remote,
    	:url => "http://selenium.mobcastdev.local:4444/wd/hub",
    	:desired_capabilities => caps)
  	end 

end  




