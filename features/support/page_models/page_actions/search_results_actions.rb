module PageModels
  module SearchResultsActions
    def switch_to_grid_view
      search_results_page.grid_view_button.click
      wait_until { search_results_page.current_view == 'grid' }
    end

    def switch_to_list_view
      search_results_page.list_view_button.click
      wait_until { search_results_page.current_view == 'list' }
    end
  end
end

World(PageModels::SearchResultsActions)