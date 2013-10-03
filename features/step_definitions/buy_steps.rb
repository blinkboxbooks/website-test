Given /^I have identified the book to buy$/ do
  returning_user_selects_a_book
end

Given /I have identified a best selling book to buy$/ do
  click_buy_now_best_seller_book
end

Given /^I choose to register$/ do
  click_register_button
end

When /^I enter valid (.*?) card details$/ do |card_type|
    enter_new_payment_details(card_type)
end

When /^I complete registration successfully$/ do
  register_new_user
end

And /^I enter valid Billing address$/  do
    enter_billing_details
end

And /^click Confirm & pay button$/ do
   click_confirm_and_pay
end

When /^I sign in successfully$/ do
  sign_in('bkm1@aa.com','test1234')
end

When /^I choose to pay with saved default card$/ do
   pay_with_saved_card
end
