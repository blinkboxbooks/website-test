module PageModels
  class NewReleasesPage < PageModels::BlinkboxbooksPage
    set_url "/#!/new"
    set_url_matcher /new/
    section :book_results, BookResults, '[data-test="search-results-list"]'
    element :new_releases_last_30days, '#newreleases'
  end

  register_model_caller_method(NewReleasesPage)
end