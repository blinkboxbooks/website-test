module PageModels
  class SignInForm < PageModels::BlinkboxbooksSection
    element :email, "input#email"
    element :password, "input#password"
    element :sign_in_button, "button", :text => "Sign in"

    def submit(email, password)
      self.email.set email
      self.password.set password
      self.should have_sign_in_button
      self.sign_in_button.click
    end
  end
end