module PageModels
  class YourAccountPage < PageModels::BlinkboxbooksPage
    set_url_matcher /account\//
    section :account_nav_frame, AccountNavFrame, ".account_frame"
    element :sign_out_button, "button", :text => "Sign out"
    element :spinner, '.load_spinner'
  end

  class OrderAndPaymentHistoryPage < PageModels::YourAccountPage
    set_url "/#!/account/order-payment-history"
    set_url_matcher /account\/order-payment-history/
    element :ordered_books, '.order_books'
    element :book_list, '.expandable'

  end

  class YourPersonalDetailsPage < PageModels::YourAccountPage
    set_url "/#!/account/personal-details"
    set_url_matcher /account\/personal-details/
    element :email_address, '#email'
    element :first_name, '#first_name'
    element :last_name, '#last_name'
    element :club_card, '#clubcard'
    element :marketing_prefs, '#newsletter'
    element :update_personal_details, "button", :text => "UPDATE PERSONAL DETAILS"
    element :change_password_link, "button", :text => "Change password"

    def fill_in_club_card(club_card)
      self.club_card.set club_card
    end

  end

  class YourPaymentsPage < PageModels::YourAccountPage
    set_url "/#!/account/your-payments"
    set_url_matcher /account\/your-payments/
    sections :saved_cards_list, CardRecord, '.payment_list li'
    element :saved_cards_container, '.payment_list'
    element :card_holder_name, '.payment_holder'
    element :card_details, '.payment_card_details'
    elements :saved_cards, '.payment_list li.ng-scope'
    element :default_card, '.payment_list li.ng-scope.payment_alt_row'
    element :card_name, 'span.payment_name'
    element :default_card_radio_button, 'div.payment_default label'
    section :delete_card_popup, DeleteCardPopup, '#delete-card'
  end

  class YourDevicesPage < PageModels::YourAccountPage
    set_url "/#!/account/your-devices"
    set_url_matcher /account\/your-devices/
    element :device_list, '.device_list'
    elements :devices, 'ul.device_list li.ng-scope'
    element :device_name, 'span.device_name'
    element :delete_device_pop_up, '#delete-card'
    element :rename_device, 'div.ng-binding span.rename'
    element :confirm_rename_device, 'div.device_editing span.blue_button'
    element :cancel_rename_device, 'div.device_editing span.cancel'
    element :rename_device_input, 'div.device_editing input.ng-pristine'
    element :delete_device, 'div.delete_device span.show_desktop'
    element :keep_device, '[data-test="close-popup"]'
    element :remove_device, 'div.buttons button.yellow_button'
    element :close_pop_up, 'section.clearfix span.ng-scope'
  end

  class ChangePasswordPage < PageModels::YourAccountPage
    set_url "/#!/account/change-password"
    set_url_matcher /account\/change-password/
    element :current_password, '#currentPassword'
    element :enter_new_password, '#password'
    element :re_enter_new_password, '#repassword'
    element :show_password, '#show'
    element :confirm_button, "button", :text => /Confirm/i
  end

  register_model_caller_method(YourAccountPage)
  register_model_caller_method(OrderAndPaymentHistoryPage)
  register_model_caller_method(YourPersonalDetailsPage)
  register_model_caller_method(YourPaymentsPage)
  register_model_caller_method(YourDevicesPage)
  register_model_caller_method(ChangePasswordPage)
end