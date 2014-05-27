module PageModels
  class Reader < PageModels::BlinkboxbooksSection
    element :page, '#reader_container'
    element :next_page_button, '.right-arrow'
    element :previous_page_button, '.left-arrow'

    def click_next_page_button
      next_page_button.click
    end

    def click_previous_page_button
      previous_page_button.click
    end
  end
end