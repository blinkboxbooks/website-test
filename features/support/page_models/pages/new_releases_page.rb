module PageModels
  class NewReleasesPage < PageModels::BlinkboxbooksPage
    set_url "/#!/new"
    set_url_matcher /new/
  end

  register_model_caller_method(NewReleasesPage)
end