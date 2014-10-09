module PageModels
  class SignInForm < PageModels::BlinkboxbooksSection
    include WaitSteps

    element :email, 'input#email'
    element :password, 'input#password'
    element :sign_in_button, 'button', :text => /Sign in/i
    element :show_password,'#showPassword'

    def submit(email, password)
      expect {all_there?}.to become_true, "Timeout waiting for sign in form elements to appear"
      self.email.set email
      self.show_password.set true
      self.password.set password
      self.sign_in_button.click
    end

    def fill_in_password(password)
      self.password.set password
    end

    def click_sign_in_button
      expect(self).to have_sign_in_button
      self.sign_in_button.click
    end
  end
end