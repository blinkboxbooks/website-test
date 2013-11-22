module PageModels
  class ConfirmAndPayPage < PageModels::BlinkboxbooksPage
    set_url_matcher /confirm/
    element :save_card, "#save_details"
  end

  register_model_caller_method(ConfirmAndPayPage)
end