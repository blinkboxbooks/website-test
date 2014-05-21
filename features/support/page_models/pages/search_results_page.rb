module PageModels
  class SearchResultsPage < PageModels::BlinkboxbooksPage
    set_url "/#!/search{?q}"
    set_url_matcher /search\?q\=/

    element :searched_term, ".searched_term"
    elements :books, "div.itemsets div[book=\"book\"]"
    sections :book_results_sections, BookResults, '[data-test="search-results-list"]'
    element :corrected_search_word_link, 'span#did_you_mean.ng-binding span.ng-scope a.ng-binding'
    element :order_by, '.orderby'
    elements :sort_options, 'div.orderby ul li.item'
    element :list_view_button, 'a[data-test="list-button"]'
    element :grid_view_button, 'a[data-test="grid-button"]'

    def current_view
      if list_view_button[:class].include? 'active'
        'list'
      else
        'grid'
      end
    end
  end
  register_model_caller_method(SearchResultsPage, :search_results_page)
end
