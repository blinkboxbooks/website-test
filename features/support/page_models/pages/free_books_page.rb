module PageModels
  class FreeBooksPage < PageModels::BlinkboxbooksPage
    set_url "/#!/free_books"
    set_url_matcher /free_books/
  end

  register_model_caller_method(FreeBooksPage)
end