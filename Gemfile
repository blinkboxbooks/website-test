source "http://artifactory.blinkbox.local/artifactory/api/gems/bbb-gems/"
source "http://artifactory.blinkbox.local/artifactory/api/gems/rubygems/"
ruby '2.0.0'

group :automation_libs do
  gem 'cucumber'
  gem 'rspec'
  gem 'rspec-collection_matchers'
  gem 'capybara', '~> 2.4'
  gem 'capybara-angular'
  gem 'selenium-webdriver', '~> 2.39'
  gem 'selendroid'
  gem 'site_prism'
  gem 'Platform'
end

group :misc_libs do
  gem 'activesupport'
  gem 'cucumber-helpers'
  gem 'i18n'
  gem 'rake'
end

group :ci do
  gem 'parallel_tests'
  gem 'headless'
end

group :api do
  gem 'multi_json'
  gem 'httpclient'
  gem 'cucumber-rest'
end

group :reporting do
  gem 'cuporter'
  gem 'cucumber-blinkbox', '~> 0.3'
end

group :debug do
  gem 'debugger'
end
