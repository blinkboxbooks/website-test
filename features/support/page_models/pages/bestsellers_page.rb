module PageModels
  class BestsellersPage < PageModels::BlinkboxbooksPage
    set_url "/#!/bestsellers"
    set_url_matcher /bestsellers/

    element :section_title_element, 'div[data-test="bestsellers-container"] h2.section_header'
    sections :book_results_sections, BookResults,'[data-test="search-results-list"]'
    section :daily_bestsellers, BookResults, '[data-category="daily-bestsellers"]'

    def section_title
      section_title_element.text
    end
  end

  register_model_caller_method(BestsellersPage)
end