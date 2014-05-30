module PageModels
  class AuthorsPage < PageModels::BlinkboxbooksPage
    set_url "/#!/authors"
    set_url_matcher /authors/
    element :section_title_element, 'h2[data-test="authors-container-title"]'
    element :featured_authors, '#featured_authors'

    def section_title
      section_title_element.text
    end
  end

  register_model_caller_method(AuthorsPage)
end