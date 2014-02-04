module PageModels
  class FreeBooksPage < PageModels::BlinkboxbooksPage
    set_url "/#!/free-books"
    set_url_matcher /free-books/
    element :top_free_books, '#topfree'
  end

  register_model_caller_method(FreeBooksPage)
end