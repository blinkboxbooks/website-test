module PageModels
  module OrderCompleteActions

    def click_on_element(name)
      element = name.downcase.gsub(' ', '_')
      order_complete_page.send(element).click
    end

  end
end
World(PageModels::OrderCompleteActions)