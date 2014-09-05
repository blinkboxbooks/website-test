module PageModels
  class FeaturedAuthor < PageModels::BlinkboxbooksSection
    element :name_element, '.author'
    element :link, 'a'

    def name
      name_element.text
    end
  end

  class AuthorsPage < PageModels::BlinkboxbooksPage
    set_url '/#!/authors'
    set_url_matcher /authors/
    element :section_title_element, 'h2[data-test="authors-container-title"]'
    sections :featured_authors, FeaturedAuthor, '#featured_authors ul.authors li'

    def section_title
      section_title_element.text
    end

    def featured_authors_names
      wait_for_featured_authors
      names = []
      featured_authors.each { |author| names << author.name }
      names
    end
  end

  register_model_caller_method(AuthorsPage)
end