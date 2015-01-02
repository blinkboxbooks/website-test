module PageModels
  module SearchResultsPageAsserts
    def assert_books_displayed_with_options(book_type, view)
      expect(bestsellers_page.selected_tab).to eq(book_type.gsub('-', '_').downcase.to_sym)
      expect(search_results_page.current_view).to eq(view.to_sym)
    end
  end
end

World(PageModels::SearchResultsPageAsserts)
