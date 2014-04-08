module PageModels
  module CategoryPageAsserts
    def assert_category_page_displayed(category_name)
      category_page.should be_displayed
      category_name.downcase.gsub(/&|'|and|,/, '').split(' ').each { |word| category_page.current_url.should include(word) }
    end
  end
end
World(PageModels::CategoryPageAsserts)