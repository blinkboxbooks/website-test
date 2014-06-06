module PageModels
  module AuthorPageAsserts
    def assert_author_page_displayed(author_name)
      expect(author_page).to be_displayed
      expect(author_page.current_url).to include(author_name.downcase.gsub(/ {1,}/, '-'))
    end
  end
end
World(PageModels::AuthorPageAsserts)
