module PageModels
  class YourAccountPage < PageModels::BlinkboxbooksPage
    set_url_matcher /account\//
    section :account_nav_frame, AccountNavFrame, ".account_frame"
  end

  class YourOrderAndPaymentHistoryPage < PageModels::YourAccountPage
    set_url "/#!/account/paymentHistory"
    set_url_matcher /account\/paymentHistory$/
  end

  class YourPersonalDetailsPage < PageModels::YourAccountPage
    set_url "/#!/account/personalDetails"
    set_url_matcher /account\/personalDetails$/
  end

  class YourPaymentsPage < PageModels::YourAccountPage
    set_url "/#!/account/myPayments"
    set_url_matcher /account\/myPayments$/
  end

  class YourDevicesPage < PageModels::YourAccountPage
    set_url "/#!/account/myDevices"
    set_url_matcher /account\/myDevices$/
  end

  register_model_caller_method(YourAccountPage)
  register_model_caller_method(YourOrderAndPaymentHistoryPage)
  register_model_caller_method(YourPersonalDetailsPage)
  register_model_caller_method(YourPaymentsPage)
  register_model_caller_method(YourDevicesPage)
end