module PageModels
  class NewReleasesPage < PageModels::BlinkboxbooksPage
    set_url '/#!/new-releases'
    set_url_matcher /new/

    sections :book_results_sections, BookResults,'[data-test="search-results-list"]'
    element :section_title_element, '[data-test="newreleases-title"]'
    section :sort_by_dropdown, SortByDropdown, '.orderby'

    def sort_by(title)
      sort_by_dropdown.select_item(title)
    end

    def section_title
      section_title_element.text
    end

    def new_releases_titles
      wait_for_book_results_sections
      titles = []
      book_results_sections[0].books.each { |book| titles << book.title }
      titles
    end
  end

  register_model_caller_method(NewReleasesPage)
end