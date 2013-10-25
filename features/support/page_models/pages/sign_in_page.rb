module PageModels
  class SignInPage < PageModels::BlinkboxbooksPage
    set_url "/#!/signin"
    set_url_matcher /signin/

    section :sign_in_form, SignInForm, "#signin"
  end

  register_model_caller_method(SignInPage)
end