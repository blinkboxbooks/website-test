module PageModels
  class ResetPasswordPage < PageModels::BlinkboxbooksPage
    set_url "#!/reset-password"
    set_url_matcher /reset-password/
    element :email_address, '#email'
    element :not_remember_email_id, "a", :text => "I can't remember which email I used"
    element :send_reset_link,"button", :text => "Send reset link"
  end

  register_model_caller_method(ResetPasswordPage)
end