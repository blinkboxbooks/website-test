module PageModels
  class BestsellersPage < PageModels::BlinkboxbooksPage
    set_url "/#!/bestsellers"
    set_url_matcher /bestsellers/
    sections :book_results_sections, BookResults,'[data-test="search-results-list"]'
  end

  register_model_caller_method(BestsellersPage)
end