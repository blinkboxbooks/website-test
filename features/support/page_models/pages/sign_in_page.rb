module PageModels
  class SignInPage < PageModels::BlinkboxbooksPage
    set_url '/#!/signin'
    set_url_matcher /signin/
    element :register_button, 'button[data-test="register-button"]'
    element :send_reset_link, '.right_column a'
    element :show_password,'#showPassword'
    section :sign_in_form, SignInForm, '#signin'
    element :forgotten_password_link, '[data-test="send-me-a-reset-link"]'
    element :remember_me, '#remember_me'
    element :error, '#error_signin'

    def navigation_timeout
      20
    end
  end

  register_model_caller_method(SignInPage)
end