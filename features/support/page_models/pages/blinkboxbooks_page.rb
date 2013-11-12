module PageModels
  class BlinkboxbooksPage < SitePrism::Page
    include RSpec::Matchers

    def navigation_timeout
      Capybara.default_wait_time
    end

    section :footer, Footer, "div#footer"
    section :header, Header, "div#header"

    def wait_until_displayed(timeout = navigation_timeout)
      r0 = Time.now
      Timeout.timeout timeout, PageModelHelpers::TimeOutWaitingForPageToAppear do
        Capybara.using_wait_time 0 do
          sleep 0.5 while not displayed?
        end
      end
    ensure
      puts "Load time of #{self.class.name.demodulize}: #{Time.now - r0} sec"
    end

    def wait_until_not_displayed(timeout = navigation_timeout)
      r0 = Time.now
      Timeout.timeout timeout, PageModelHelpers::TimeOutWaitingForPageToDisappear do
        Capybara.using_wait_time 0 do
          sleep 0.5 while displayed?
        end
      end
    ensure
      puts "Processing time of #{self.class.name.demodulize}: #{Time.now - r0} sec"
    end
  end

  def current_page
    @_current_page ||= BlinkboxbooksPage.new
  end
end