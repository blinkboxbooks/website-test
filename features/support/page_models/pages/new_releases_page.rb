module PageModels
  class NewReleasesPage < PageModels::BlinkboxbooksPage
    set_url "/#!/new"
    set_url_matcher /new/
    element :new_releases_last_30days, '#newreleases'
    sections :book_results_sections, BookResults,'[data-test="search-results-list"]'
  end

  register_model_caller_method(NewReleasesPage)
end