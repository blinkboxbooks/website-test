module PageModels
  module CategoryPageAsserts
    def assert_category_page_displayed(category_name)
      category_page.should be_displayed
      title = category_name.downcase.gsub(/&|'|and|,/, '').gsub(/ +/, '-')
      category_page.current_url.should include(title)
    end
  end
end
World(PageModels::CategoryPageAsserts)