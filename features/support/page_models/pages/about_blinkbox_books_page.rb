module PageModels
  class AboutBlinkboxBooksPage < PageModels::BlinkboxbooksPage
    set_url "/#!/about-blinkbox-books"
    set_url_matcher /about\-blinkbox\-books/
  end

  register_model_caller_method(AboutBlinkboxBooksPage)
end