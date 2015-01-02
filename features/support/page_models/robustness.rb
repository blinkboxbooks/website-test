module MakeTestsRobust
  def setup
    page.execute_script <<-JS
      window.ajaxDone = false;
      var app = angular.element(document.querySelector('[ng-app]'));
      var $injector = app.injector();

      $injector.invoke(function($browser) {
        $browser.notifyWhenNoOutstandingRequests(function() {
          window.ajaxDone = true;
        });
      });
    JS
  end

  def reset
    page.execute_script('window.ajaxDone = false;')
  end

  def timeout?(start)
    Time.now - start > Capybara.default_wait_time
  end

  def timeout!
    raise TimeoutError, "Timeout waiting for AJAX execution - waited #{Capybara.default_wait_time}"
  end

  def ajax_done?
    page.evaluate_script('window.ajaxDone')
  end

  def is_setup?
    page.evaluate_script("! (typeof(window.ajaxDone) === 'undefined')")
  end
end

# Borrowed from Spreewald suite.
module ToleranceForSeleniumSyncIssues
  RETRY_ERRORS = %w[
    Capybara::ElementNotFound
    Spec::Expectations::ExpectationNotMetError
    RSpec::Expectations::ExpectationNotMetError
    Capybara::Poltergeist::ClickFailed
    Capybara::ExpectationNotMet
    Selenium::WebDriver::Error::StaleElementReferenceError
    Selenium::WebDriver::Error::NoAlertPresentError
    Selenium::WebDriver::Error::ElementNotVisibleError
    Selenium::WebDriver::Error::NoSuchFrameError
    Selenium::WebDriver::Error::NoAlertPresentError
  ]

  # This is similiar but not entirely the same as Capybara::Node::Base#wait_until or Capybara::Session#wait_until
  def patiently(seconds = Capybara.default_wait_time, &block)
    old_wait_time = Capybara.default_wait_time
    # dont make nested wait_untils use up all the alloted time
    Capybara.default_wait_time = 0 # for we are a jealous gem
    if page.driver.wait?
      start_time = Time.now
      begin
        block.call
      rescue => e
        raise e unless RETRY_ERRORS.include?(e.class.name)
        raise e if (Time.now - start_time) >= seconds
        sleep(0.05)
        raise Capybara::FrozenInTime, 'time appears to be frozen, Capybara does not work with libraries which freeze time, consider using time travelling instead' if Time.now == start_time
        retry
      end
    else
      block.call
    end
  ensure
    Capybara.default_wait_time = old_wait_time
  end
end

World(ToleranceForSeleniumSyncIssues)
World(MakeTestsRobust)

if config_flag_on?(TEST_CONFIG['WAIT_FOR_AJAX'])
  puts 'Waiting for AJAX to complete.'

  AfterStep do
    setup

    start = Time.now
    until ajax_done?
      timeout! if timeout?(start)

      sleep(0.01)
    end

    reset
  end
end
