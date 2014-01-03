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
    element :email_address, '#email'
    element :first_name, '#first_name'
    element :last_name, '#last_name'
    element :club_card, '#clubcard'
    element :marketing_prefs, '#newsletter'
    element :update_personal_details, "button", :text => "Update personal details"
    element :change_password_link, "button", :text => "Change password"

    def fill_in_club_card(club_card)
      self.club_card.set club_card
    end

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