module PageModels
  class RegistrationSuccessPage < PageModels::BlinkboxbooksPage
    set_url '/#!/success'
    set_url_matcher /success/
    element :welcome_label, 'div#success'
  end

  register_model_caller_method(RegistrationSuccessPage, :registration_success_page)
end