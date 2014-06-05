module PageModels
  class NewReleasesPage < PageModels::BlinkboxbooksPage
    set_url "/#!/new-releases"
    set_url_matcher /new/
    element :new_releases_last_30days, '#newreleases'
    sections :book_results_sections, BookResults,'[data-test="search-results-list"]'
    element :section_title_element, '[data-test="newreleases-title"]'

    def section_title
      section_title_element.text
    end
  end

  register_model_caller_method(NewReleasesPage)
end