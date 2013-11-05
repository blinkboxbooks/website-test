module PageModels
  class YourAccountPage < PageModels::BlinkboxbooksPage
    set_url_matcher /account\//
    section :account_nav_frame, AccountNavFrame, ".account_frame"
  end

  class YourOrderAndPaymentHistoryPage < PageModels::YourAccountPage
    set_url "/#!/account/order-payment-history"
    set_url_matcher /account\/order-payment-history/
  end

  class YourPersonalDetailsPage < PageModels::YourAccountPage
    set_url "/#!/account/personal-details"
    set_url_matcher /account\/personal-details/
  end

  class YourPaymentsPage < PageModels::YourAccountPage
    set_url "/#!/account/your-payments"
    set_url_matcher /account\/your-payments/
  end

  class YourDevicesPage < PageModels::YourAccountPage
    set_url "/#!/account/your-devices"
    set_url_matcher /account\/your-devices/
  end

  register_model_caller_method(YourAccountPage)
  register_model_caller_method(YourOrderAndPaymentHistoryPage)
  register_model_caller_method(YourPersonalDetailsPage)
  register_model_caller_method(YourPaymentsPage)
  register_model_caller_method(YourDevicesPage)
end