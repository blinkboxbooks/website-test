module PageModels
  class SearchResultsPage < PageModels::BlinkboxbooksPage
    set_url "/#!/search{?q}"
    set_url_matcher /search\?q\=/

    elements :results, "div.itemsets div.book"
  end

  register_model_caller_method(SearchResultsPage, :search_results_page)
end