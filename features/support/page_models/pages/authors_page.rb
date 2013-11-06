module PageModels
  class AuthorsPage < PageModels::BlinkboxbooksPage
    set_url "/#!/authors"
    set_url_matcher /authors/

    def navigation_timeout
      15
    end
  end

  register_model_caller_method(AuthorsPage)
end