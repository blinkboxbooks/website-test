module PageModels
  class BlinkboxbooksPage < SitePrism::Page
    include RSpec::Matchers

    def navigation_timeout
      Capybara.default_wait_time
    end

    section :footer, Footer, "div#footer"
    section :header, Header, "header#outer-header"
    section :search_form, SearchForm, "div#searchbox-input"

    def wait_until_displayed(timeout = navigation_timeout)
      r0 = Time.now
      Timeout.timeout timeout, PageModelHelpers::TimeOutWaitingForPageToAppear do
        SitePrism::Waiter.wait_until_true(timeout) { displayed? }
      end
      ensure
        puts "Load time of #{self.class.name.demodulize}: #{Time.now - r0} sec"
    end

    def wait_until_not_displayed(timeout = navigation_timeout)
      r0 = Time.now
      Timeout.timeout timeout, PageModelHelpers::TimeOutWaitingForPageToAppear do
        SitePrism::Waiter.wait_until_true(timeout) { not displayed? }
      end
      ensure
        puts "Processing time of #{self.class.name.demodulize}: #{Time.now - r0} sec"
    end
  end

  def current_page
    @_current_page ||= BlinkboxbooksPage.new
  end
end