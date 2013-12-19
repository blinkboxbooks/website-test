module PageModels
  class RegisterPage < PageModels::BlinkboxbooksPage
    set_url "/#!/register"
    set_url_matcher /register/

    element :first_name, '#first_name'
    element :last_name, '#last_name'
    element :email, '#email'
    element :password, '#password'
    element :password_repeat, '#repassword'
    element :terms_and_conditions, '#termsconditions'
    element :register_button, "button", :text => "Register"
    element :cancel_registration, "a", :text => "Cancel registration"
    element :confirm_cancel_registration, "button", :text =>  "Leave this page"

    element :errors_section, "#error_signin"

    def has_errors?
      self.has_errors_section?
    end

    def fill_in_personal_details(first_name, last_name, email_address)
      self.first_name.set first_name
      self.last_name.set last_name
      self.email.set email_address
    end

    def fill_in_password(password)
      self.password.set password
      self.password_repeat.set password
    end
  end

  register_model_caller_method(RegisterPage, :register_page)
end