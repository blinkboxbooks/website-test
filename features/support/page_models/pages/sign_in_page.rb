module PageModels
  class SignInPage < PageModels::BlinkboxbooksPage
    set_url "/#!/signin"
    set_url_matcher /signin/
    element :register_button, "button", :text => /Register/i
    element :send_reset_link, "a", :text => /Send me a reset link/i
    element :show_password,'#showPassword'
    section :sign_in_form, SignInForm, "#signin"
  end

  register_model_caller_method(SignInPage)
end