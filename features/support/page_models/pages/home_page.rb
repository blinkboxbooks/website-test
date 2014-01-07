module PageModels
  class HomePage < PageModels::BlinkboxbooksPage
    set_url "/"
    set_url_matcher Regexp.new("#{Capybara.app_host}\/?(?:#!/)?$")
    element :book_in_the_news, '#books_news'
    element :editors_picks, '#editors_picks'
  end

  register_model_caller_method(HomePage)
end