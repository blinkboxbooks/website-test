module PageModels
  class ResetPasswordPage < PageModels::BlinkboxbooksPage
    set_url '#!/reset-password'
    set_url_matcher(/reset-password/)

    element :email_address, '#email'
    element :send_reset_link, 'button[data-test="send-reset-link-button"]'
    element :reset_message_error, '.error'
  end

  register_model_caller_method(ResetPasswordPage)
end
