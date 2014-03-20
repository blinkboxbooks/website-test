module PageModels
  module OrderCompleteActions

    def click_on_element(name)
      element = name.titlecase_to_underscore_case
      order_complete_page.send(element).click
    end

  end
end
World(PageModels::OrderCompleteActions)