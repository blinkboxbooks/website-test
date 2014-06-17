module PageModels
  module CategoryPageAsserts
    def assert_category_page_displayed(category_name)
      expect(category_page).to be_displayed
      title = category_name.downcase.gsub(/&|'|and|,/, '').gsub(/ +/, '-')
      expect(category_page.current_url).to include(title)
    end
  end
end
World(PageModels::CategoryPageAsserts)