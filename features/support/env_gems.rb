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

# ======= Require helper libraries =======
def require_rel_and_log(lib_array)
  lib_array = [lib_array] if lib_array.class != Array
  lib_array.sort!
  lib_array.each { |file|
    unless $".include?(file.to_s)
      puts("Loading #{file}") if TEST_CONFIG['debug']
      require_rel(lib_array)
    end
  }
end
