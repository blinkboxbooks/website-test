module PageModels
  class Pagination < PageModels::BlinkboxbooksSection
    elements :pagination_numbers, '[data-test^="pagination"] li'
    element :previous_button, '[data-test="pagination-previous"]'
    element :next_button, '[data-test="pagination-next"]'

    def wait_for_pagination_controls
      wait_for_pagination_numbers
      wait_until_pagination_numbers_visible
    end

    def click_on_previous_button
      wait_for_pagination_controls
      previous_button.click
    end

    def click_on_next_button
      wait_for_pagination_controls
      next_button.click
    end

    def click_on_pagination_number(page_number)
      wait_for_pagination_controls
      pagination_numbers[page_number.to_i - 1].find('a').click
    end

    def selected_page_number
      wait_for_pagination_controls
      pagination_numbers.find { |page| page[:class].include?('active') }
    end
  end
end
