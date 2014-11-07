module PageModels
  class BestsellersPage < PageModels::BlinkboxbooksPage
    set_url '/#!/bestsellers'
    set_url_matcher /bestsellers/

    sections :book_results_sections, BookResults, '[data-test="search-results-list"]'
    section :daily_bestsellers, BookResults, '[data-category="daily-bestsellers"]'
    element :section_title_element, 'div[data-test="bestsellers-container"] h2.section_header'
    element :daily_bestsellers_title_element, 'div.top h2.section_header'
    element :fiction_tab, '[data-test="bestsellers-container"] a', :text => 'Fiction', :match => :first
    element :non_fiction_tab, '[data-test="bestsellers-container"] a', :text => 'Non-Fiction', :match => :first
    element :fiction_button, '.tabbed a', :text => 'Fiction'
    element :non_fiction_button, '.tabbed a', :text => 'Non-Fiction'
    section :sort_by_dropdown, SortByDropdown, '.orderby'

    def sort_by(title)
      sort_by_dropdown.select_item(title)
    end

    def daily_bestsellers_title
      wait_for_daily_bestsellers_title_element
      daily_bestsellers_title_element.text
    end

    def section_title
      section_title_element.text
    end

    def selected_tab
      if fiction_tab.find(:xpath, '..')[:class].include?('selected')
        :fiction
      elsif non_fiction_tab.find(:xpath, '..')[:class].include?('selected')
        :non_fiction
      else
        :none
      end
    end
  end

  register_model_caller_method(BestsellersPage)
end