module PageModels
  module OrderCompleteActions

    def click_button(button_name)
      button = button_name.downcase.gsub(' ', '_') + '_button'
      order_complete_page.send(button).click
    end

  end
end
World(PageModels::OrderCompleteActions)