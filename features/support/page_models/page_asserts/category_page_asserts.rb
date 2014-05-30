module PageModels
  module CategoryPageAsserts
    def assert_category_page_displayed(category_name)
      category_page.should be_displayed
      title = category_name.downcase.gsub(/&|'|and|,/, '').gsub(/ +/, '-')
      expect(current_url).to include(title), "Probably page URL is wrong, current page is #{current_url}"
    end
  end
end
World(PageModels::CategoryPageAsserts)