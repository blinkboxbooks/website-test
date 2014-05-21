module PageModels
  class HomePage < PageModels::BlinkboxbooksPage
    set_url "/"
    set_url_matcher Regexp.new("#{Capybara.app_host}\/?(?:#!/)?$")

    section :highlights_category, HomePageCategory, '#books_news'
    section :spotlight_on_category, HomePageCategory, '#editors_picks'

    sections :book_results_sections, BookResults,'[data-test="search-results-list"]'
    section :banner, Banner, '[id="slider"]'
  end

  register_model_caller_method(HomePage)
end