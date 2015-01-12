module PageModels
  class TermsAndConditionsPage < PageModels::BlinkboxbooksPage
    set_url '/#!/terms-conditions'
    set_url_matcher(/terms\-conditions/)
  end

  register_model_caller_method(TermsAndConditionsPage)
end
