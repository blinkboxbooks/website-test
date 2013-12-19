module PageModels
  class ConfirmAndPayPage < PageModels::BlinkboxbooksPage
    set_url_matcher /confirm/
    element :save_card, "#save_details"
    element :pay_with_new_card, "button", :text => "Pay with a new card"
    element :confirm_and_pay, "button", :text => "Confirm & pay"
    element :confirm_order, "button", :text => "Confirm order"
    element :cancel_order_link, "a", :text => "Cancel order"
    element :confirm_cancel_button, "button", :text => "Cancel order"
  end

  register_model_caller_method(ConfirmAndPayPage)
end