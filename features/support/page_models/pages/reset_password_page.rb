module PageModels
  class ResetPasswordPage < PageModels::BlinkboxbooksPage
    set_url "#!/reset-password"
    set_url_matcher /reset-password/
    element :email_address, '#email'
    element :not_remember_email_id, 'a[data-test="cant-remember-email-link"]'
    element :send_reset_link, 'button[data-test="send-reset-link-button"]'
  end

  register_model_caller_method(ResetPasswordPage)
end