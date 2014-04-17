module PageModels
  module AuthorPageAsserts
    def assert_author_page_displayed(author_name)
      author_page.should be_displayed
      author_page.current_url.should include(author_name.downcase.gsub(' ', '-'))
    end
  end
end
World(PageModels::AuthorPageAsserts)
