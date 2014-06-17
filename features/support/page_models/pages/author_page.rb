module PageModels
  class AuthorPage < PageModels::BlinkboxbooksPage
    set_url '/#!/author/{id}/{name}'
    set_url_matcher /author\/[0-9a-z]+\/[a-z\-]+/
  end

  register_model_caller_method(AuthorPage)
end