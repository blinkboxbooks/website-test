module PageModels
  class ConfirmAndPayPage < PageModels::BlinkboxbooksPage
    set_url_matcher /confirm/
  end

  register_model_caller_method(ConfirmAndPayPage)
end