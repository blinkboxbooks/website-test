Given /^I have identified the book to buy$/ do
  returning_user_selects_a_book('summer')
end

Given /I have identified a best selling book to buy$/ do
  click_buy_now_best_seller_book
end

When /^I enter valid (.*?) card details$/ do |card_type|
    enter_new_payment_details(card_type)
end

And /^I enter valid Billing address$/  do
    enter_billing_details
end

And /^I confirm my payment details$/ do
   click_confirm_and_pay
end

When /^I pay with saved default card$/ do
   pay_with_saved_card
end

When /^I choose to pay with a new card$/ do
    click_pay_with_new_card
end

And /^I choose not to save the payment details$/ do
  uncheck('save_details')
end

And /^I have identified a free book to buy$/ do
  returning_user_selects_a_book('Free')
end
When /^I click Confirm order$/ do
  click_confirm_order
end
