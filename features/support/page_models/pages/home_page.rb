module PageModels
  class HomePage < PageModels::BlinkboxbooksPage
    set_url "/"
    set_url_matcher Regexp.new("#{Capybara.app_host}\/?(?:#!/)?$")
    section :book_results, BookResults, "#books_news.promo_rows div.expandable ul.grid"
    element :book_in_the_news, '#books_news'
    element :editors_picks, '#editors_picks'
  end

  register_model_caller_method(HomePage)
end