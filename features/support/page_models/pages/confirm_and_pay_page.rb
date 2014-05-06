module PageModels
  class ConfirmAndPayPage < PageModels::BlinkboxbooksPage
    set_url_matcher /confirm/
    element :details_view, 'div#confirm-pay-card-details-view'
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
    element :pay_with_new_card, "button", :text => /Pay with a new card/i
    element :confirm_and_pay, "button", :text => /Confirm & Pay/i
    element :confirm_order, "button", :text => /Confirm Order/i
    element :cancel_order_link, "a", :text => /Cancel Order/i
    element :confirm_cancel_button, "button", :text => /Cancel Order/i
    element :account_credit_payment, '#credit-on-account'
    element :account_credit_amount, '.credit-amount'
    element :amount_left_to_pay, 'div.left-to-pay-amount'
    element :card_payment, '#confirm-pay-view'
    element :card_icon_visa, 'span[title="Visa"]'
    element :card_icon_mastercard, 'span[title="Mastercard"]'
    element :title_element, '#inner-register-navigation', :visible => true

    def title
      title_element.text.downcase
    end

  end

  register_model_caller_method(ConfirmAndPayPage)
end