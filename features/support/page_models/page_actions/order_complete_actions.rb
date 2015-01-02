module PageModels
  module OrderCompleteActions
    def click_button_on_order_complete(name)
      element = name.titlecase_to_underscore_case
      order_complete_page.send(element).click
    end
  end
end

World(PageModels::OrderCompleteActions)
