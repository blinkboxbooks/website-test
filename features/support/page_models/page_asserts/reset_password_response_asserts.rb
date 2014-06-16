module PageModels
  module ResetPasswordResponseAsserts

    def assert_reset_email_confirmation
      expect(reset_password_response_page).to have_email_confirm_message
      expect(reset_password_response_page.email_confirm_message.text).to include("We've sent you a password reset email")
    end

  end
end
World(PageModels::ResetPasswordResponseAsserts)