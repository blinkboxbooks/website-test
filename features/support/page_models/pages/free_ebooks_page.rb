module PageModels
  class FreeEbooksPage < PageModels::BlinkboxbooksPage
    set_url "/#!/free-books"
    set_url_matcher /free-books/
    element :top_free_books, '#topfree'
    sections :book_results_sections, BookResults,'[data-test="search-results-list"]'
    element :section_title_element, 'div[data-test="topfree-container"] h2.section_header'

    def section_title
      section_title_element.text
    end
  end

  register_model_caller_method(FreeEbooksPage)
end