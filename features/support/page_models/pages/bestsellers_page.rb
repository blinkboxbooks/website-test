module PageModels
  class BestsellersPage < PageModels::BlinkboxbooksPage
    set_url "/#!/bestsellers"
    set_url_matcher /bestsellers/

    sections :book_results_sections, BookResults, '[data-test="search-results-list"]'
    section :daily_bestsellers, BookResults, '[data-category="daily-bestsellers"]'
    element :section_title_element, 'div[data-test="bestsellers-container"] h2.section_header'
    element :fiction_tab, '[data-test="bestsellers-container"] a', :text => 'Fiction'
    element :non_fiction_tab, '[data-test="bestsellers-container"] a', :text => 'Non-Fiction'
    element :fiction_button, '.tabbed a', :text => 'Fiction'
    element :non_fiction_button, '.tabbed a', :text => 'Non-Fiction'

    def section_title
      section_title_element.text
    end

    def selected_tab
      if fiction_tab[:class] =~ 'selected'
        :fiction
      elsif non_fiction_tab[:class] =~ 'selected'
        :non_fiction
      end
    end
  end

  register_model_caller_method(BestsellersPage)
end