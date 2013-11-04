module PageModels
  class RegisterPage < PageModels::BlinkboxbooksPage
    set_url "/#!/register"
    set_url_matcher /register/
    element :register_button, "button", :text => "Register"

  end

  register_model_caller_method(RegisterPage)
end