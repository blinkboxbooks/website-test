module PageModels
  class BlinkboxbooksPage < SitePrism::Page
    include RSpec::Matchers

    section :footer, Footer, "div#footer"
    section :header, Header, "div#header"
  end

  def current_page
    @_current_page ||= BlinkboxbooksPage.new
  end
end