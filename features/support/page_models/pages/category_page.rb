module PageModels
  class CategoryPage < PageModels::BlinkboxbooksPage
    set_url "/#!/category"
    set_url_matcher /category/
    section :book_results, BookResults, '[data-test="search-results-list"]'
    element :category_books, '#category'
  end

  register_model_caller_method(CategoryPage)
end