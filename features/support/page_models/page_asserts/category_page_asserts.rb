module PageModels
  module CategoryPageAsserts
    def assert_category_page_displayed(category_name)
      category_page.should be_displayed
      expect(category_page).to show(category_name), "Probably wrong Category is displayed. Expected #{category_name}, current page is #{current_page.inspect}"
    end
  end
end
World(PageModels::CategoryPageAsserts)