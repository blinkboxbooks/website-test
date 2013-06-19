require 'capybara'
require 'capybara/dsl'
require 'capybara/cucumber'
require 'selenium-webdriver'

Capybara.default_driver = :selenium
Capybara.default_wait_time = 5
Capybara.app_host = ENV['BASE_URL'] # picks up BASE_URL from command line profile


