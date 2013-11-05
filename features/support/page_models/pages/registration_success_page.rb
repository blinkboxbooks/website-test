module PageModels
  class RegistrationSuccessPage < PageModels::BlinkboxbooksPage
    set_url "/#!/success"
    set_url_matcher /success/
    element :welcome_label, '.welcome'

    def has_welcome_message?
      self.has_selector?('.welcome')
    end
  end

  register_model_caller_method(RegistrationSuccessPage)
end