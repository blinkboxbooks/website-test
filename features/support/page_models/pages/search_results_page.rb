module PageModels
  class SearchResultsPage < PageModels::BlinkboxbooksPage
    set_url '/#!/search{?q}'
    set_url_matcher /search\?q=/

    element :searched_term_element, '.searched_term'
    sections :book_results_sections, BookResults, '[data-test="search-results-list"]'
    element :corrected_search_word_link, 'span#did_you_mean.ng-binding span.ng-scope a.ng-binding'
    element :order_by, '.orderby .item'
    elements :sort_options, 'div.orderby ul li.item'
    element :list_view_button, 'a[data-test="list-button"]'
    element :grid_view_button, 'a[data-test="grid-button"]'
    element :no_results_element, '#noResults'
    element :book_cover, '[data-test=book-title-cover]'
    element :number_of_results_element, 'div#searchMatch'

    def number_of_results_found
      number_of_results_element.text[/\d+/].to_i
    end

    def current_view
      if has_list_view_button?
        list_view_button[:class].include?('active') ? :list : :grid
      else
        nil
      end
    end

    def no_results_message
      has_no_results_element? ? no_results_element.text : ''
    end

    def searched_term
      searched_term_element.text.gsub('"','').strip
    end
  end
  register_model_caller_method(SearchResultsPage, :search_results_page)
end
