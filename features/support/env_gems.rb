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
require 'cucumber/blinkbox/environment'
require 'cucumber/blinkbox/data_dependencies'
require 'platform'
require 'require_all'

# ======= Custom method to log required local helper libraries =======
module RequireAllExtensions
  def require_rel_and_log(*args)
    # Handle passing an array as an argument
    args.flatten!
    args.each { |file| puts "Loading #{file}" } if TEST_CONFIG['debug']
    require_rel(args)
  end
end

include RequireAllExtensions
