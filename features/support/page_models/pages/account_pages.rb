module PageModels
  class YourAccountPage < PageModels::BlinkboxbooksPage
    set_url_matcher /account\//
    section :account_nav_frame, AccountNavFrame, '#content'
    element :sign_out_button, 'button', :text => 'Sign out'
    element :spinner, '.load_spinner'
    element :account_message_books_element, '[data-test="account-message-books"]'
    element :account_message_devices_element, '[data-test="account-message-devices"]'

    def account_message_books
      wait_for_account_message_books_element
      /\d+/.match(account_message_books_element.text)[0].to_i
    end

    def account_message_devices
      wait_for_account_message_devices_element
      /\d+/.match(account_message_devices_element.text)[0].to_i
    end
  end

  class OrderAndPaymentHistoryPage < PageModels::YourAccountPage
    set_url '/#!/account/order-payment-history'
    set_url_matcher /account\/order-payment-history/
    element :ordered_books, '.order_books'
    element :book_list, '.expandable'
  end

  class SamplesPage < PageModels::YourAccountPage
    set_url '/#!/account/samples'
    set_url_matcher /account\/samples/
    sections :samples_section, SampleResults, 'expandable itemsets'
    section :highlights_section, BookResults, '#books_news'
    sections :sample_list, SampleResults, '.order_books'
  end

  class YourPersonalDetailsPage < PageModels::YourAccountPage
    set_url '/#!/account/personal-details'
    set_url_matcher /account\/personal-details/
    element :email_address, '#email'
    element :first_name_element, '#first_name'
    element :last_name_element, '#last_name'
    element :club_card, '#clubcard'
    element :marketing_prefs, '#newsletter'
    element :marketing_prefs_label, 'label.pseudo_label[for="newsletter"]'
    element :update_personal_details, "button", :text => "UPDATE PERSONAL DETAILS"
    element :change_password_link, 'a.arrowedlink'
    element :confirm_button, 'button[data-test="confirm-button"]'

    def fill_in_club_card(club_card)
      self.club_card.set club_card
    end

    def confirm_changes
      confirm_button.click
    end

    def first_name
      wait_for_first_name_element
      first_name_element.value
    end

    def last_name
      wait_for_last_name_element
      last_name_element.value
    end

  end

  class YourPaymentsPage < PageModels::YourAccountPage
    set_url "/#!/account/your-payments"
    set_url_matcher /account\/your-payments/
    sections :saved_cards_list, CardRecord, '.payment_list li'
    element :saved_cards_container, '.payment_list'
    element :card_holder_name, '.payment_holder'
    element :card_details, '.payment_card_details'
    element :card_name, 'span.payment_name'
    element :default_card_radio_button, 'div.payment_default label'
    section :delete_card_popup, DeleteCardPopup, '#delete-card'

    def default_card
      wait_until_saved_cards_container_visible
      saved_cards.each { |card| return card if card.is_default? }
    end

    def saved_cards
      wait_until_saved_cards_list_visible
      saved_cards_list
    end

    def has_credit_card?(card_type, *args)
      cards = saved_cards.select { |card| card.type == card_type }
      cards.select! do |card|
        args.all? { |prop| card.send(prop.to_a.first[0]).downcase == prop.to_a.first[1].downcase }
      end
      sleep 5
      !cards.empty?
    end
  end

  class YourDevicesPage < PageModels::YourAccountPage
    set_url '/#!/account/your-devices'
    set_url_matcher /account\/your-devices/
    element :device_list, '.device_list'
    elements :devices, 'ul.device_list li.ng-scope'
    element :device_name, 'span.device_name'
    section :delete_device_pop_up, DeleteDevicePopup, '#delete-card'
    element :rename_device, 'div.ng-binding span.rename'
    element :confirm_rename_device, 'div.device_editing span.blue_button'
    element :cancel_rename_device, 'div.device_editing span.cancel'
    element :rename_device_input, 'div.device_editing input.ng-pristine'
    element :delete_device, 'div.delete_device span.show_desktop'
  end

  class ChangePasswordPage < PageModels::YourAccountPage
    set_url "/#!/account/change-password"
    set_url_matcher /account\/change-password/
    element :current_password, '#currentPassword'
    element :enter_new_password, '#password'
    element :re_enter_new_password, '#repassword'
    element :show_password, '#show'
    element :confirm_button, 'button[data-test="confirm-button"]'
    element :error_sign_in_popup, '#error_signin'

  end

  register_model_caller_method(YourAccountPage)
  register_model_caller_method(OrderAndPaymentHistoryPage)
  register_model_caller_method(SamplesPage)
  register_model_caller_method(YourPersonalDetailsPage)
  register_model_caller_method(YourPaymentsPage)
  register_model_caller_method(YourDevicesPage)
  register_model_caller_method(ChangePasswordPage)
end
