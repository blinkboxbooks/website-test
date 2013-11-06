module PageModels
  class BlinkboxbooksPage < SitePrism::Page
    include RSpec::Matchers

    def navigation_timeout
      Capybara.default_wait_time
    end

    section :footer, Footer, "div#footer"
    section :header, Header, "div#header"

    def wait_until_displayed(timeout = navigation_timeout)
      Timeout.timeout timeout, PageModelHelpers::TimeOutWaitingForPageToAppear do
        Capybara.using_wait_time 0 do
          sleep 0.5 while not displayed?
        end
      end
    end

    def wait_until_not_displayed(timeout = navigation_timeout)
      Timeout.timeout timeout, PageModelHelpers::TimeOutWaitingForPageToDisappear do
        Capybara.using_wait_time 0 do
          sleep 0.5 while displayed?
        end
      end
    end
  end

  def current_page
    @_current_page ||= BlinkboxbooksPage.new
  end
end