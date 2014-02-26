module PageModels
  class ResetPasswordResponsePage < PageModels::BlinkboxbooksPage
    set_url "#!/reset-password-response"
    set_url_matcher /reset-password-response/
    element :email_confirm_message, '#content'

    def assert_reset_password_message reset_email
      within email_confirm_message do
        page.should have_content "We've sent you an email"
        page.should have_content "Please check your inbox at #{reset_email} Follow the link in the email to set a new password"
      end
    end
  end

  register_model_caller_method(ResetPasswordResponsePage)
end