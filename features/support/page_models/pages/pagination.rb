module PageModels
  class Pagination < PageModels::BlinkboxbooksPage
    set_url '/{page}?page={page_number}'
    set_url_matcher /\?page=\d+/


    elements :pagination_numbers, '[data-test^="pagination"] li'
    element :previous_button, '[data-test="pagination-previous"]'
    element :next_button, '[data-test="pagination-next"]'

    def click_on_previous_button
      wait_until_pagination_numbers_visible
      previous_button.click
      wait_until_pagination_numbers_visible
    end

    def click_on_next_button
      wait_until_pagination_numbers_visible
      next_button.click
    end

    def click_on_pagination_number(page_number)
      wait_until_pagination_numbers_visible
      pagination_numbers[page_number.to_i-1].find('a').click
    end

    def selected_page_number
      wait_until_pagination_numbers_visible
      pagination_numbers.find { |page| page[:class].include?('active') }
    end

    def load(page_name, page_number)
      if page_name == 'search result'
        super({:page => 'search', :page_number => page_number})
      elsif page_name == 'free books'
        super({:page => 'free-books', :page_number => page_number})
      elsif page_name == 'new releases'
        super({:page => 'new-releases', :page_number => page_number})
      elsif page_name == 'authors'
        super({:page => 'authors', :page_number => page_number})
      elsif page_name == 'category'
        super({:page => 'category/fiction-literature', :page_number => page_number})
      end
    end

  end
  register_model_caller_method(Pagination, :pagination)
end

