module PageModels
  class RegisterPage < PageModels::BlinkboxbooksPage
    set_url "/#!/register"
    set_url_matcher /register/

    element :register_button, "button", :text => "Register"
    element :errors_section, "#error_signin"

    def has_errors?
      self.has_selector?("#error_signin")
    end
  end

  register_model_caller_method(RegisterPage, :register_page)
end