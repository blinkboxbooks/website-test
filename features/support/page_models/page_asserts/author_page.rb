module PageModels
  module AuthorPageAsserts
    def assert_author_page_displayed(author_name)
      expect(author_page).to be_displayed
      expect(author_page.current_url).to include(author_name.downcase.gsub(/ +/, '-'))
    end

    def assert_authors_page_displayed
      authors_page.wait_until_featured_authors_visible
      expect_page_displayed('Authors')
    end
  end
end
World(PageModels::AuthorPageAsserts)
