module PageModels
  class Reader < PageModels::BlinkboxbooksSection
    element :next_page_button, '.right-arrow'
    element :previous_page_button, '.left-arrow'

    def turn_to_next_page
      next_page_button.click
    end

    def turn_back_to_previous_page
      previous_page_button.click
    end
  end
end