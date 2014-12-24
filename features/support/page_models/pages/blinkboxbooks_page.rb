module PageModels
  class BlinkboxbooksPage < SitePrism::Page
    include WebUtilities
    include Utilities
    include WaitSteps

    def self.set_navigation_timeout navigation_timeout
      @navigation_timeout = navigation_timeout
    end

    def self.navigation_timeout
      @navigation_timeout ||= Capybara.default_wait_time
    end

    def navigation_timeout
      self.class.navigation_timeout
    end

    def self.set_load_checker(&block)
      @load_checker = block
    end

    def self.load_checker
      @load_checker ||= Proc.new {true}
    end

    def load_checker
      self.class.load_checker
    end

    def displayed?(seconds = navigation_timeout)
      super(seconds) && load_checker.call(self)
    end

    def wait_until_displayed(timeout = navigation_timeout)
      r0 = Time.now
        SitePrism::Waiter.wait_until_true(timeout) { displayed? }
      rescue SitePrism::TimeoutException
        raise PageModelHelpers::TimeOutWaitingForPageToAppear.new, 'Timed out waiting for page to be displayed'
      ensure
        puts "Load time of #{self.class.name.demodulize}: #{Time.now - r0} sec"
    end

    def wait_until_not_displayed(timeout = navigation_timeout)
      r0 = Time.now
        SitePrism::Waiter.wait_until_true(timeout) { not displayed? }
      rescue SitePrism::TimeoutException
        raise PageModelHelpers::TimeOutWaitingForPageToAppear.new, 'Timed out waiting for page not to be displayed'
      ensure
        puts "Processing time of #{self.class.name.demodulize}: #{Time.now - r0} sec"
    end

    section :footer, Footer, '[data-test="footer-container"]'
    section :header, Header, 'header#outer-header'
    section :search_form, SearchForm, 'div#searchbox-input'
  end

  def current_page
    @_current_page ||= BlinkboxbooksPage.new
  end
end
