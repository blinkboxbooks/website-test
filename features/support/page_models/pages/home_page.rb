module PageModels
  class HomePage < SitePrism::Page
    set_url "/"
    set_url_matcher Regexp.new(Capybara.app_host)

    section :footer, Footer, "#footer"
  end

  register_model_caller_method(HomePage)
end