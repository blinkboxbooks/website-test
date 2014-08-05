module PageModels
  class ResetPasswordPage < PageModels::BlinkboxbooksPage
    set_url '#!/reset-password'
    set_url_matcher /reset-password/

    element :email_address, '#email'
    element :send_reset_link, 'button[data-test="send-reset-link-button"]'

    def click_send_reset_password_link
      send_reset_link.click
    end
  end

  register_model_caller_method(ResetPasswordPage)
end