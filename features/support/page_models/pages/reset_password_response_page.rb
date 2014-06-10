module PageModels
  class ResetPasswordResponsePage < PageModels::BlinkboxbooksPage
    set_url_matcher /reset-password-response/
    element :email_confirm_message, '#content'
  end

  register_model_caller_method(ResetPasswordResponsePage)
end