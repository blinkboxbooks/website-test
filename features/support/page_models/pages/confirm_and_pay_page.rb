module PageModels
  class ConfirmAndPayPage < PageModels::BlinkboxbooksPage
    set_url_matcher /confirm/
    element :save_card, '#save_details'
    element :cvv , '#number_cvv'
    element :name_on_card, '#card_name'
    element :card_number, '#number_card'
    element :expiry_month, '#card_dates_month'
    element :expiry_year, '#card_dates_year'
    element :address_line_one, '#address_one'
    element :address_line_two, '#address_two'
    element :town_or_city, '#address_three'
    element :postcode, '#address_four'
    element :pay_with_new_card, "button", :text => "Pay with a new card"
    element :confirm_and_pay, "button", :text => "CONFIRM & PAY"
    element :confirm_order, "button", :text => "CONFIRM ORDER"
    element :cancel_order_link, "a", :text => "Cancel order"
    element :confirm_cancel_button, "button", :text => "CANCEL ORDER"
  end

  register_model_caller_method(ConfirmAndPayPage)
end