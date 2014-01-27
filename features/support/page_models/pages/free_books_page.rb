module PageModels
  class FreeBooksPage < PageModels::BlinkboxbooksPage
    set_url "/#!/free-books"
    set_url_matcher /free-books/
    section :book_results, BookResults, '[data-test="search-results-list"]'
    element :top_free_books, '#topfree'
  end

  register_model_caller_method(FreeBooksPage)
end