module PageModels
  class SearchResultsPage < PageModels::BlinkboxbooksPage
    set_url "/#!/search{?q}"
    set_url_matcher /search\?q\=/

    elements :books, "div.itemsets div[book=\"book\"]"

    #did not make it to work, gave up due to lack of time
    #section :book_results, BookItems, "div.itemsets"
  end

  register_model_caller_method(SearchResultsPage, :search_results_page)
end